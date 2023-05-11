import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class GetForecast implements UseCase<Weather, Params> {
  final WeatherRepository repository;

  GetForecast(this.repository);

  @override
  Future<Either<Failure, Weather>> call(Params params) async {
    return await repository.getForecast(params.city);
  }
}

class Params extends Equatable {
  final String city;

  const Params({required this.city});

  @override
  List<Object> get props => [city];
}
