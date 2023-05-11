import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';

class Weather extends Equatable {
  final String temperature;
  final String wind;
  final String description;
  final List<Forecast> forecast;

  const Weather({
    required this.temperature,
    required this.wind,
    required this.description,
    required this.forecast,
  });

  @override
  List<Object> get props => [temperature, wind, description, forecast];
}
