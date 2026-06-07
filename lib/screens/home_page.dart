import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/favorites_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  final FavoritesService _favoritesService = FavoritesService();

  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _currentWeather;
  List<Map<String, dynamic>>? _forecast;
  List<String> _favorites = [];

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadFavorites();

    // Listener para que el botón de búsqueda se actualice al escribir
    _cityController.addListener(() {
      setState(() {});
    });

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  void _loadFavorites() async {
    final favs = await _favoritesService.getFavorites();
    setState(() => _favorites = favs);
  }

  void _searchWeather() async {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _currentWeather = null;
      _forecast = null;
    });

    try {
      final weather = await _weatherService.getCurrentWeather(city);
      final forecast = await _weatherService.getForecast(city);

      setState(() {
        _currentWeather = weather;
        _forecast = forecast;
      });

      _fadeController.reset();
      _fadeController.forward();
    } catch (e) {
      setState(() {
        _error = "City not found or API error";
        _currentWeather = null;
        _forecast = null;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _addFavorite() async {
    if (_currentWeather == null) return;
    final city = _currentWeather!['name'];
    await _favoritesService.addFavorite(city);
    _loadFavorites();
  }

  void _removeFavorite(String city) async {
    await _favoritesService.removeFavorite(city);
    _loadFavorites();
  }

  Widget _buildWeatherInfo() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return Center(child: Text(_error!));
    if (_currentWeather == null) return const SizedBox.shrink();

    String iconCode = _currentWeather!['weather'][0]['icon'];
    String iconUrl = "https://openweathermap.org/img/wn/$iconCode@2x.png";

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(iconUrl, width: 50, height: 50),
              const SizedBox(width: 8),
              Text(
                "Weather in ${_currentWeather!['name']}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "${_currentWeather!['main']['temp']} °C, ${_currentWeather!['weather'][0]['description']}",
            style: const TextStyle(fontSize: 18),
          ),
          Text("Max: ${_currentWeather!['main']['temp_max']} °C, Min: ${_currentWeather!['main']['temp_min']} °C"),
          Text("Humidity: ${_currentWeather!['main']['humidity']}%, Wind: ${_currentWeather!['wind']['speed']} m/s"),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _addFavorite, child: const Text("Add to favorites")),
          const SizedBox(height: 16),
          const Text("5-day forecast:", style: TextStyle(fontSize: 20)),
          for (var item in _forecast ?? [])
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              builder: (context, value, child) => Opacity(opacity: value, child: child),
              child: Row(
                children: [
                  Image.network("https://openweathermap.org/img/wn/${item['icon']}@2x.png", width: 30, height: 30),
                  const SizedBox(width: 8),
                  Expanded(child: Text("${item['date']}: ${item['temperature']} °C, ${item['description']}")),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFavorites() {
    if (_favorites.isEmpty) return const Text("No favorites yet.");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _favorites.map((city) {
        return ListTile(
          title: Text(city),
          trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => _removeFavorite(city)),
          onTap: () {
            _cityController.text = city;
            _searchWeather();
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
          bottom: const TabBar(tabs: [Tab(text: "Search"), Tab(text: "Favorites")]),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: "City", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _cityController.text.trim().isEmpty ? null : _searchWeather,
                    child: const Text("Search"),
                  ),
                  const SizedBox(height: 16),
                  Expanded(child: SingleChildScrollView(child: _buildWeatherInfo())),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.all(16), child: SingleChildScrollView(child: _buildFavorites())),
          ],
        ),
      ),
    );
  }
}