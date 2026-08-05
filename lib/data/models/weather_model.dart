class WeatherModel {
  WeatherModel({
    required this.temperature,
  });

  final double temperature;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final currentWeather = json['current_weather'] as Map<String, dynamic>;
    return WeatherModel(
      temperature: (currentWeather['temperature'] as num).toDouble(),
    );
  }
}
