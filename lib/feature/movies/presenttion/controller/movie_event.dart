import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesEvent extends MovieEvent {
  final int page;
  final bool isRefresh;

  const GetPopularMoviesEvent({this.page = 1, this.isRefresh = false});

  @override
  List<Object> get props => [page, isRefresh];
}

class LoadMoreMoviesEvent extends MovieEvent {}
