import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../feature/movies/data/datasources/movie_local_data_source.dart';
import '../../feature/movies/data/datasources/movie_remote_data_source.dart';
import '../../feature/movies/data/repositories/movie_repository_impl.dart';
import '../../feature/movies/domain/repositories/movie_repository.dart';
import '../../feature/movies/domain/usecases/get_popular_movies.dart';
import '../../feature/movies/presenttion/controller/movie_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => MovieBloc(getPopularMovies: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPopularMovies(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => _createDio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  // Add interceptors for logging (optional)
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ),
  );

  return dio;
}
