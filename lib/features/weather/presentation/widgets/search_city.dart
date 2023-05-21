import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';

class SearchCity extends StatefulWidget {
  const SearchCity({super.key});

  @override
  State<StatefulWidget> createState() => _SearchCity();
}

class _SearchCity extends State<StatefulWidget> {
  final controller = TextEditingController();
  String city = ' ';

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => city = value,
      onSubmitted: (_) {
        controller.clear();
        BlocProvider.of<WeatherBloc>(context, listen: false)
            .add(GetWeather(city));
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: 'what location are you looking for?',
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }
}
