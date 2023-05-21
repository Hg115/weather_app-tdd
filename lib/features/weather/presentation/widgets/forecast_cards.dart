import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';

class ForecastCards extends StatelessWidget {
  final List<Forecast> forecast;

  const ForecastCards({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _StatItem(forecast: forecast[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: forecast.length,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final Forecast forecast;

  const _StatItem({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Dia
          const _CardsContainer(message: 'Dia'),
          _CardsForecastValue(forecast: forecast.day),
          const SizedBox(width: 10),

          //Temperatura
          const _CardsContainer(message: 'Temperatura'),
          _CardsForecastValue(forecast: forecast.temperature),
          const SizedBox(width: 10),

          //Viento
          const _CardsContainer(message: 'Viento'),
          _CardsForecastValue(forecast: forecast.wind),
        ],
      ),
    );
  }
}

class _CardsForecastValue extends StatelessWidget {
  const _CardsForecastValue({
    required this.forecast,
  });

  final String forecast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        forecast,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _CardsContainer extends StatelessWidget {
  final String message;
  const _CardsContainer({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        message,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
