class CityModel {
  CityModel({
    required this.name,
    required this.lat,
    required this.lon,
  });

  final String name;
  final String lat;
  final String lon;

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['display_name'] as String,
      lat: json['lat'] as String,
      lon: json['lon'] as String,
    );
  }
}
