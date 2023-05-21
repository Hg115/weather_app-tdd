import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/temperature_color.dart';

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.weather,
    required this.mensaje,
    this.icon,
  });

  final String weather;
  final String mensaje;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              //Posibles Colores Morado o Verde
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              mensaje,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8.0),
          DisplayTemperature(temperature: weather)
        ],
      ),
    );
  }
}
