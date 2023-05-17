import 'package:weather_app/features/weather/domain/entities/forecast.dart';

class ForecastModel extends Forecast {
  const ForecastModel(
      {required super.day, required super.temperature, required super.wind});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      day: json["day"],
      temperature: json["temperature"],
      wind: json["wind"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "day": day,
      "temperature": temperature,
      "wind": wind,
    };
  }
}
