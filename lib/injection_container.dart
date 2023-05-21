import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usescases/get_weather_by_city.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

void init() {
  //Bloc
  sl.registerFactory(
    () => WeatherBloc(
      getForecast: sl(),
    ),
  );

  //Use Cases
  sl.registerLazySingleton(() => GetForecast(sl()));

  //Repository

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  //Data Source
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External.
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
