part of 'city_bloc.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}

final class LoadingCityState extends CityState {}

final class ErrorCityState extends CityState {}

final class SearchedCityState extends CityState {
  const SearchedCityState({required this.cities});

  final List<CityModel> cities;

  @override
  List<Object> get props => [cities];
}

final class GetWeatherState extends CityState {
  const GetWeatherState({required this.weather});

  final WeatherModel weather;

  @override
  List<Object> get props => [weather];
}
