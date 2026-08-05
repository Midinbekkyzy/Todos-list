import 'package:dio/dio.dart';
import 'package:lesson5/data/models/city_model.dart';
import 'package:lesson5/data/models/weather_model.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class WeatherRepository {
  WeatherRepository() {
    dio.interceptors.add(TalkerDioLogger());
  }

  final Dio dio = Dio();

  Future<List<CityModel>> searchCity(String city) async {
    final Response response = await dio.get(
      'https://nominatim.openstreetmap.org/search?q=$city&format=json',
      options: Options(
        headers: {'User-Agent': 'lesson5-weather-app'},
      ),
    );

    final listResponse = response.data as List;
    final List<CityModel> cities = [];
    for (final element in listResponse) {
      cities.add(CityModel.fromJson(element));
    }
    return cities;
  }

  Future<WeatherModel> getWeather(String lat, String lon) async {
    final Response response = await dio.get(
      'https://api.open-meteo.com/v1/forecast',
      queryParameters: {
        'latitude': lat,
        'longitude': lon,
        'current_weather': true,
      },
    );

    return WeatherModel.fromJson(response.data);
  }
}
