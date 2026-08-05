import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson5/ui/city/bloc/city_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    super.key,
    required this.lat,
    required this.lon,
  });

  final String lat;
  final String lon;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final CityBloc _cityBloc = CityBloc();

  @override
  void initState() {
    _cityBloc.add(
      GetWeatherEvent(
        lat: widget.lat,
        lon: widget.lon,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _cityBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<CityBloc, CityState>(
          bloc: _cityBloc,
          builder: (context, state) {
            if (state is GetWeatherState) {
              return Text(
                '${state.weather.temperature}C',
                style: TextStyle(fontSize: 50),
              );
            }
            if (state is ErrorCityState) {
              return Text(
                'Error',
                style: TextStyle(fontSize: 30, color: Colors.red),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
