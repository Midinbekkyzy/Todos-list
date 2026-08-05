import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lesson5/data/models/city_model.dart';
import 'package:lesson5/data/models/weather_model.dart';
import 'package:lesson5/data/repository/weather_repository.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final WeatherRepository _repo = WeatherRepository();

  CityBloc() : super(CityInitial()) {
    on<SearchCityEvent>((event, emit) async {
      try {
        emit(LoadingCityState());
        final cities = await _repo.searchCity(event.searchCity);
        emit(SearchedCityState(cities: cities));
      } catch (e) {
        emit(ErrorCityState());
      }
    });

    on<GetWeatherEvent>((event, emit) async {
      try {
        emit(LoadingCityState());
        final weather = await _repo.getWeather(event.lat, event.lon);
        emit(GetWeatherState(weather: weather));
      } catch (e) {
        emit(ErrorCityState());
      }
    });
  }
}
