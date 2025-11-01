import 'package:hive/hive.dart';

import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends Movie {
  @HiveField(0)
  final int movieId;

  @HiveField(1)
  final String movieTitle;

  @HiveField(2)
  final String movieOverview;

  @HiveField(3)
  final String moviePosterPath;

  @HiveField(4)
  final String movieBackdropPath;

  @HiveField(5)
  final double movieVoteAverage;

  @HiveField(6)
  final String movieReleaseDate;

  @HiveField(7)
  final int page;

  const MovieModel({
    required this.movieId,
    required this.movieTitle,
    required this.movieOverview,
    required this.moviePosterPath,
    required this.movieBackdropPath,
    required this.movieVoteAverage,
    required this.movieReleaseDate,
    this.page = 1,
  }) : super(
         id: movieId,
         title: movieTitle,
         overview: movieOverview,
         posterPath: moviePosterPath,
         backdropPath: movieBackdropPath,
         voteAverage: movieVoteAverage,
         releaseDate: movieReleaseDate,
       );

  factory MovieModel.fromJson(Map<String, dynamic> json, {int page = 1}) {
    return MovieModel(
      movieId: json['id'] ?? 0,
      movieTitle: json['title'] ?? '',
      movieOverview: json['overview'] ?? '',
      moviePosterPath: json['poster_path'] ?? '',
      movieBackdropPath: json['backdrop_path'] ?? '',
      movieVoteAverage: (json['vote_average'] ?? 0).toDouble(),
      movieReleaseDate: json['release_date'] ?? '',
      page: page,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': movieId,
      'title': movieTitle,
      'overview': movieOverview,
      'poster_path': moviePosterPath,
      'backdrop_path': movieBackdropPath,
      'vote_average': movieVoteAverage,
      'release_date': movieReleaseDate,
    };
  }
}

// Run this command to generate the adapter:
// flutter packages pub run build_runner build --delete-conflicting-outputs
