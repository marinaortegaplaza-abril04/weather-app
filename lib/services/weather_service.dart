import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "46e35a71688716e284da474a85f74033";

  Future<Map<String, dynamic>> getCurrentWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("City not found");
    }
  }

  Future<List<Map<String, dynamic>>> getForecast(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['list'];
      return list.map<Map<String, dynamic>>((item) {
        return {
          "date": item['dt_txt'],
          "temperature": item['main']['temp'].toString(),
          "description": item['weather'][0]['description'],
          "icon": item['weather'][0]['icon'],
          "temp_min": item['main']['temp_min'].toString(),
          "temp_max": item['main']['temp_max'].toString(),
          "humidity": item['main']['humidity'].toString(),
          "wind_speed": item['wind']['speed'].toString(),
        };
      }).toList();
    } else {
      throw Exception("City not found");
    }
  }
}