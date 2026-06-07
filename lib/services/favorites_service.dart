import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _key = "favorites";

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addFavorite(String city) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    if (!favorites.contains(city)) {
      favorites.add(city);
      await prefs.setStringList(_key, favorites);
    }
  }

  Future<void> removeFavorite(String city) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    favorites.remove(city);
    await prefs.setStringList(_key, favorites);
  }
}