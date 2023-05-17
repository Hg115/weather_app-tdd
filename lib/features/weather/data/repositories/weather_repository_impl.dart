import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';

import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getForecast(String city) async {
    if (await networkInfo.isConnected) {
      final remoteCity = await remoteDataSource.getForecastWeather(city);
      return Right(remoteCity);
    } else {
      return Left(ServerFailure());
    }
  }
}
