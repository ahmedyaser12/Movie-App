import 'package:hive/hive.dart';

import '../../../../core/exciption/exciption.dart';
import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getCachedMovies(int page);

  Future<void> cacheMovies(List<MovieModel> movies, int page);

  Future<void> clearCache();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  static const String moviesBoxName = 'movies';
  static const String metaBoxName = 'movie_meta';
  static const String lastPageKey = 'last_page';

  Future<Box<MovieModel>> get _moviesBox async =>
      await Hive.openBox<MovieModel>(moviesBoxName);

  Future<Box> get _metaBox async => await Hive.openBox(metaBoxName);

  @override
  Future<List<MovieModel>> getCachedMovies(int page) async {
    try {
      final box = await _moviesBox;

      // Get movies for specific page
      final cachedMovies = box.values
          .where((movie) => movie.page == page)
          .toList();

      if (cachedMovies.isEmpty) {
        throw CacheException('No cached data found for page $page');
      }

      return cachedMovies;
    } catch (e) {
      throw CacheException('Failed to get cached movies: $e');
    }
  }

  @override
  Future<void> cacheMovies(List<MovieModel> movies, int page) async {
    try {
      final box = await _moviesBox;

      for (var movie in movies) {
        await box.put('${movie.movieId}_$page', movie);
      }

      final metaBox = await _metaBox;
      await metaBox.put(lastPageKey, page);
    } catch (e) {
      throw CacheException('Failed to cache movies: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final box = await _moviesBox;
      await box.clear();
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }
}
