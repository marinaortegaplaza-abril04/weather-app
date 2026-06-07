import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/forecast_item.dart';

void main() {
  test('ForecastItem is created correctly from JSON', () {
    final json = {
      'date': '2026-06-08 12:00:00',
      'temperature': '25.5',
      'description': 'clear sky',
      'icon': '01d',
      'temp_min': '24.0',
      'temp_max': '27.0',
      'humidity': '40',
      'wind_speed': '3.5',
    };

    final item = ForecastItem.fromJson(json);

    expect(item.date, '2026-06-08 12:00:00');
    expect(item.temperature, '25.5');
    expect(item.description, 'clear sky');
    expect(item.icon, '01d');
    expect(item.tempMin, '24.0');
    expect(item.tempMax, '27.0');
    expect(item.humidity, '40');
    expect(item.windSpeed, '3.5');
  });
}