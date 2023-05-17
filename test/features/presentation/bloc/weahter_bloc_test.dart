import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/usescases/get_weather_by_city.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';

@GenerateNiceMocks([
  MockSpec<GetForecast>(),
])
import 'weahter_bloc_test.mocks.dart';

void main() {
  late MockGetForecast mockGetForecast;
  late WeatherBloc bloc;

  setUp(() {
    mockGetForecast = MockGetForecast();
    bloc = WeatherBloc(getForecast: mockGetForecast);
  });

  const tWeather =
      Weather(description: '', temperature: '', wind: '', forecast: []);
  const tCity = "Caracas";

  test(
    "initial state should be empty",
    () async {
      //assert
      expect(bloc.state, Empty());
    },
  );

  group('GetForecast', () {
    test(
      'should get the forecast with the use case',
      () async {
        // arrange
        when(mockGetForecast(any))
            .thenAnswer((_) async => const Right(tWeather));

        // act
        bloc.add(const GetWeather(tCity));
        await untilCalled(mockGetForecast(any));

        // assert
        verify(mockGetForecast(const ParamsCity(city: tCity)));
      },
    );

    test(
      'should emit [LoadedWeather] when data is added successfully',
      () async {
        // arrange
        when(mockGetForecast(any))
            .thenAnswer((_) async => const Right(tWeather));
        // assert later
        final expected = [
          //const LoadedWeather(tWeather),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(const GetWeather(tCity));
      },
    );

    test(
      'should emit [Error] when adding data fails',
      () async {
        // arrange
        when(mockGetForecast(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          const Error(message: serverFailureMessage),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(const GetWeather(tCity));
      },
    );

    test(
      'should emit [Error] with a proper message for the error',
      () async {
        // arrange

        when(mockGetForecast(any))
            .thenAnswer((_) async => Left(ServerMaintenance()));

        // assert later
        final expected = [
          const Error(message: serverMaintenanceMessage),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(const GetWeather(tCity));
      },
    );
  });
}
