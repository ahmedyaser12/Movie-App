// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 0;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      movieId: fields[0] as int,
      movieTitle: fields[1] as String,
      movieOverview: fields[2] as String,
      moviePosterPath: fields[3] as String,
      movieBackdropPath: fields[4] as String,
      movieVoteAverage: fields[5] as double,
      movieReleaseDate: fields[6] as String,
      page: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.movieTitle)
      ..writeByte(2)
      ..write(obj.movieOverview)
      ..writeByte(3)
      ..write(obj.moviePosterPath)
      ..writeByte(4)
      ..write(obj.movieBackdropPath)
      ..writeByte(5)
      ..write(obj.movieVoteAverage)
      ..writeByte(6)
      ..write(obj.movieReleaseDate)
      ..writeByte(7)
      ..write(obj.page);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
