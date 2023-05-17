import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';

@GenerateNiceMocks(
    [MockSpec<WeatherRemoteDataSource>(), MockSpec<NetworkInfo>()])
import 'weather_repository_impl_test.mocks.dart';

void main() {
  late WeatherRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockWeatherRemoteDataSource);
  });

  group("getForecast", () {
    const tCity = "Caracas";

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      await repository.getForecast(tCity);

      //assert
      verify(mockNetworkInfo.isConnected);
    });
  });
}
