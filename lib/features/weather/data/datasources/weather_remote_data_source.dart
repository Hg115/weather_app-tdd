import 'dart:convert';

import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

abstract class WeatherRemoteDataSource {
  ///Calls the https://goweather.herokuapp.com/weather/{city} endpoint.
  ///
  ///Throw a [ServerException] for all error codes.
  Future<Weather> getForecastWeather(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<Weather> getForecastWeather(String city) =>
      _getTriviaFromUrl('https://goweather.herokuapp.com/weather/$city');

  Future<WeatherModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
