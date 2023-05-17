import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/weather/data/models/forecast_model.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import 'package:weather_app/features/weather/domain/usescases/get_weather_by_city.dart';

import 'get_weather_by_city_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
void main() {
  late GetForecast usecase;
  late MockWeatherRepository mockWeatherRepository;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetForecast(mockWeatherRepository);
  });

  const tForecast = [
    ForecastModel(day: "1", temperature: "32 °C", wind: "3 km/h"),
    ForecastModel(day: "2", temperature: "29 °C", wind: "4 km/h"),
    ForecastModel(day: "3", temperature: "26 °C", wind: "7 km/h"),
  ];

  const tWeather = WeatherModel(
      temperature: "30 °C",
      wind: "11 km/h",
      description: "Sunny",
      forecast: tForecast);

  const tCity = "Caracas";
  test(
    "should get weather by city from the repository",
    () async {
      //arrange
      when(mockWeatherRepository.getForecast(any))
          .thenAnswer((_) async => const Right(tWeather));

      //act
      final result = await usecase(const ParamsCity(city: tCity));

      expect(result, const Right(tWeather));
      verify(mockWeatherRepository.getForecast(tCity));
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
