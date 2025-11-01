import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_popular_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies getPopularMovies;

  MovieBloc({required this.getPopularMovies}) : super(MovieInitial()) {
    on<GetPopularMoviesEvent>(_onGetPopularMovies);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
  }

  Future<void> _onGetPopularMovies(
    GetPopularMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.isRefresh) {
      // If refreshing, show current movies with loading indicator
      if (state is MovieLoaded) {
        final currentState = state as MovieLoaded;
        emit(currentState.copyWith(isLoadingMore: true));
      } else {
        emit(MovieLoading());
      }
    } else {
      emit(MovieLoading());
    }

    final failureOrMovies = await getPopularMovies(Params(page: event.page));

    failureOrMovies.fold(
      (failure) => emit(MovieError(message: failure.message)),
      (movies) {
        if (event.isRefresh) {
          // Replace movies on refresh
          emit(
            MovieLoaded(
              movies: movies,
              currentPage: event.page,
              hasReachedMax: movies.isEmpty,
            ),
          );
        } else {
          // Initial load
          emit(
            MovieLoaded(
              movies: movies,
              currentPage: event.page,
              hasReachedMax: movies.isEmpty,
            ),
          );
        }
      },
    );
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final currentState = state;

    if (currentState is! MovieLoaded || currentState.hasReachedMax) {
      return;
    }

    if (currentState.isLoadingMore) {
      return; // Already loading more
    }

    // Show loading indicator
    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final failureOrMovies = await getPopularMovies(Params(page: nextPage));

    failureOrMovies.fold(
      (failure) {
        emit(currentState.copyWith(isLoadingMore: false));
        // You could emit an error state here or show a snackbar
      },
      (newMovies) {
        if (newMovies.isEmpty) {
          emit(
            currentState.copyWith(hasReachedMax: true, isLoadingMore: false),
          );
        } else {
          emit(
            MovieLoaded(
              movies: List.of(currentState.movies)..addAll(newMovies),
              currentPage: nextPage,
              hasReachedMax: false,
              isLoadingMore: false,
            ),
          );
        }
      },
    );
  }
}
