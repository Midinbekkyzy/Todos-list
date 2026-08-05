part of 'city_bloc.dart';

sealed class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object?> get props => [];
}

final class SearchCityEvent extends CityEvent {
  const SearchCityEvent({required this.searchCity});

  final String searchCity;

  @override
  List<Object?> get props => [searchCity];
}

final class GetWeatherEvent extends CityEvent {
  const GetWeatherEvent({
    required this.lat,
    required this.lon,
  });

  final String lat;
  final String lon;

  @override
  List<Object?> get props => [lat, lon];
}
