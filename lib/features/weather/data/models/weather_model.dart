import 'package:weather_app/features/weather/data/models/forecast_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel(
      {required super.temperature,
      required super.wind,
      required super.description,
      required super.forecast});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json["temperature"],
      wind: json["wind"],
      description: json["description"],
      forecast: List<ForecastModel>.from(
          json["forecast"].map((x) => ForecastModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "temperature": temperature,
      "wind": wind,
      "description": description,
      "forecast": forecast,
    };
  }
}
