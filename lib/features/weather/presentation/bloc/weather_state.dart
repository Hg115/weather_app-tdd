part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class Empty extends WeatherState {}

class Loading extends WeatherState {}

class LoadedWeather extends WeatherState {
  final Weather weather;

  const LoadedWeather({required this.weather});

  @override
  List<Object> get props => [weather];
}

class Error extends WeatherState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
