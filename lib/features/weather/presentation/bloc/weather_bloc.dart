import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usescases/get_weather_by_city.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const serverFailureMessage = 'Fallo del servidor';
const serverMaintenanceMessage = 'Servidor en mantenimiento';
const invalidInputMessage = 'Debe ingresar el nombre de la ciudad o región';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetForecast getForecast;
  WeatherBloc({required this.getForecast}) : super(Empty()) {
    on<GetWeather>((event, emit) async {
      final failureOrWeather = await getForecast(ParamsCity(city: event.city));

      emit(failureOrWeather.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (weather) => LoadedWeather(weather: weather),
      ));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case ServerMaintenance:
        return serverMaintenanceMessage;
      default:
        return 'Unexpected error';
    }
  }
}
