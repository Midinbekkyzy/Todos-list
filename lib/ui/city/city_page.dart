import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson5/data/models/city_model.dart';
import 'package:lesson5/ui/city/bloc/city_bloc.dart';
import 'package:lesson5/ui/weather/weather_page.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final CityBloc _cityBloc = CityBloc();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _cityBloc.close();
    super.dispose();
  }

  void _search() {
    if (_controller.text.isNotEmpty) {
      _cityBloc.add(SearchCityEvent(searchCity: _controller.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Поиск города')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'введи город',
                    ),
                    onSubmitted: (_) {
                      _search();
                    },
                  ),
                ),
                IconButton(
                  onPressed: _search,
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CityBloc, CityState>(
              bloc: _cityBloc,
              builder: (context, state) {
                if (state is ErrorCityState) {
                  return Center(child: Text('Error'));
                }
                if (state is SearchedCityState) {
                  return ListView.builder(
                    itemCount: state.cities.length,
                    itemBuilder: (context, index) {
                      final CityModel city = state.cities[index];
                      return ListTile(
                        title: Text(city.name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return WeatherPage(
                                  lat: city.lat,
                                  lon: city.lon,
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                if (state is LoadingCityState) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(child: Text('найди город'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
