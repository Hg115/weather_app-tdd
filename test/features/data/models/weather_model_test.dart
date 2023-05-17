import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/data/models/forecast_model.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tForecast = [
    ForecastModel(day: "1", temperature: "26 °C", wind: "5 km/h"),
    ForecastModel(day: "2", temperature: "26 °C", wind: "2 km/h"),
    ForecastModel(day: "3", temperature: "+29 °C", wind: "2 km/h"),
  ];

  const tWeather = WeatherModel(
      temperature: "+29 °C",
      wind: "15 km/h",
      description: "Sunny",
      forecast: tForecast);
  test(
    "Should be a subclass of Forecast Entity ",
    () async {
      expect(tWeather, isA<WeatherModel>());
    },
  );

  group('FromJson', () {
    test(
      "should return a valid model",
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('weather.json'));
        //act
        final result = WeatherModel.fromJson(jsonMap);
        //assert
        expect(result, tWeather);
      },
    );
  });

  group("ToJson", () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //act
        final result = tWeather.toJson();

        //assert
        final expectedMap = {
          'temperature': "+29 °C",
          'wind': "15 km/h",
          'description': "Sunny",
          'forecast': tForecast
        };

        expect(result, expectedMap);
      },
    );
  });
}
