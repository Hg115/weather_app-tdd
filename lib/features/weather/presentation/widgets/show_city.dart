import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_app/features/weather/presentation/widgets/widgets.dart';

import '../../domain/entities/weather.dart';

class DisplayCity extends StatelessWidget {
  final Weather weather;
  final List<Forecast> forecast;

  const DisplayCity({super.key, required this.weather, required this.forecast});

  @override
  Widget build(BuildContext context) {
    Color colorBackgroundTemperatura =
        getColorFromTemperature(weather.temperature);
    return Stack(
      children: [
        Container(
          height: 550,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorBackgroundTemperatura
                    .withOpacity(0.7), // Color principal con opacidad
                colorBackgroundTemperatura
                    .withOpacity(0.7), // Color secundario con opacidad
              ],
              begin: Alignment
                  .bottomCenter, // Inicio del gradiente en la parte inferior
              end:
                  Alignment.topCenter, // Fin del gradiente en la parte superior
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Weather(weather: weather),
              ForecastCards(forecast: forecast),
            ],
          ),
        ),
      ],
    );
  }
}

class _Weather extends StatelessWidget {
  final Weather weather;

  const _Weather({required this.weather});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Cards(
          weather: weather.temperature,
          mensaje: 'Temperatura',
        ),
        const SizedBox(height: 25),
        Cards(
          weather: weather.wind,
          mensaje: 'Viento',
        ),
        const SizedBox(height: 25),
        Cards(
          weather: weather.description,
          mensaje: 'Descripcion',
        ),
      ],
    );
  }
}

Color getColorFromTemperature(String temperature) {
  // Limpiar la cadena de temperatura de caracteres no deseados
  String cleanedTemperature = temperature.replaceAll(RegExp(r'[^\d.]'), '');

  // Extraer el valor numérico de la temperatura
  double valtemp = double.parse(cleanedTemperature);

  if (valtemp >= 30.0) {
    return Colors.red;
  } else if (valtemp >= 20.0) {
    return Colors.orange;
  } else if (valtemp >= 10.0) {
    return Colors.yellow;
  }

  return Colors.blue;
}
