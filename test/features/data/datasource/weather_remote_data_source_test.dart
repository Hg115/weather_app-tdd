import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

import '../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'weather_remote_data_source_test.mocks.dart';

void main() {
  late WeatherRemoteDataSourceImpl datasource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    datasource = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('weather.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('GetForecast', () {
    const city = "Caracas";
    final tWeather =
        WeatherModel.fromJson(json.decode(fixture('weather.json')));

    test(
      '''should perfom a get request on a url with an id being the endpoint and with application/json header''',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        datasource.getForecastWeather(city);
        //assert
        verify(mockHttpClient.get(
          Uri.parse('https://goweather.herokuapp.com/weather/$city'),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      "should return Forecast City when the response is 200 (success)",
      () async {
        //arrange
        setUpMockHttpClientSuccess200();

        //act
        final result = await datasource.getForecastWeather(city);
        //assert
        expect(result, equals(tWeather));
      },
    );

    test(
      "should throw a ServerException when the response is 404 or other",
      () async {
        //arrange
        setUpMockHttpClientFailure404();
        //act
        final call = datasource.getForecastWeather;
        //assert
        expect(() => call(city), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
