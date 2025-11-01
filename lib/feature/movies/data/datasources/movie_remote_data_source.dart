import 'package:dio/dio.dart';

import '../../../../core/constant/api_constants.dart';
import '../../../../core/exciption/exciption.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies(int page);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.popularMoviesEndpoint}',
        queryParameters: {'language': 'en-US', 'page': page},
        options: Options(headers: ApiConstants.headers),
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];

        return results
            .map((movieJson) => MovieModel.fromJson(movieJson, page: page))
            .toList();
      } else {
        throw ServerException('Failed to load movies: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException('Failed to connect to the server: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
