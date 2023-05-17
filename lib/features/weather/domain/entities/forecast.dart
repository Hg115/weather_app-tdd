import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final String day;
  final String temperature;
  final String wind;

  const Forecast({
    required this.day,
    required this.temperature,
    required this.wind,
  });

  @override
  List<Object> get props => [day, temperature, wind];
}
