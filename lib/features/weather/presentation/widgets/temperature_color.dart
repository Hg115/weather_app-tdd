import 'package:flutter/material.dart';

class DisplayTemperature extends StatelessWidget {
  final String temperature;

  const DisplayTemperature({Key? key, required this.temperature})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double?>(
      future: extractTemperature(temperature),
      builder: (BuildContext context, AsyncSnapshot<double?> snapshot) {
        Color backgroundColor = snapshot.hasData
            ? getColorFromTemperature(snapshot.data!)
            : Colors.grey;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            temperature,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}

Color getColorFromTemperature(double temperature) {
  if (temperature >= 30.0) {
    return Colors.red;
  } else if (temperature >= 20.0 && temperature <= 29.0) {
    return Colors.orange;
  } else if (temperature >= 10.0 && temperature <= 19.0) {
    return Colors.yellow;
  } else {
    return Colors.blue;
  }
}

Future<double?> extractTemperature(String temperatureString) async {
  final pattern = RegExp(r'(\d+(?:\.\d+)?)');
  final matches = pattern.allMatches(temperatureString);

  if (matches.isNotEmpty) {
    final match = matches.first;
    final numberString = match.group(0);
    final number = double.tryParse(numberString!);
    return number;
  }

  return null;
}
