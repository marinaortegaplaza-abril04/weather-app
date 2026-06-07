class ForecastItem {
  final String date;
  final String temperature;
  final String description;
  final String icon;
  final String tempMin;
  final String tempMax;
  final String humidity;
  final String windSpeed;

  ForecastItem({
    required this.date,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      date: json['date'] ?? '',
      temperature: json['temperature']?.toString() ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '01d',
      tempMin: json['temp_min']?.toString() ?? '',
      tempMax: json['temp_max']?.toString() ?? '',
      humidity: json['humidity']?.toString() ?? '',
      windSpeed: json['wind_speed']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'temperature': temperature,
      'description': description,
      'icon': icon,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'humidity': humidity,
      'wind_speed': windSpeed,
    };
  }
}