import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Weather App"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              _Header(),
              SizedBox(height: 20),
              _Content(),
            ],
          ),
        ));
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(height: 20),
          Text(
            ' Busca el clima según la localidad',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 20),
          SearchCity(),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is Error) return DisplayMensaje(mensaje: state.message);

        if (state is LoadedWeather) {
          return DisplayCity(
            weather: state.weather,
            forecast: state.weather.forecast,
          );
        }

        return const DisplayMensaje(mensaje: 'No has buscado una Ciudad aún');
      },
    );
  }
}
