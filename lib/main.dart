import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/injection_container.dart' as inj;

import 'features/weather/presentation/pages/homepage.dart';

void main() {
  inj.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => inj.sl<WeatherBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (_) => const HomePage(),
        },
        theme: _themeData(),
      ),
    );
  }

  ThemeData _themeData() {
    return ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo, elevation: 0));
  }
}
