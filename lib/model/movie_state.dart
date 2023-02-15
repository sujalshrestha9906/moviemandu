import 'package:moviemandu/model/movie.dart';

class MovieState {
  final bool isLoad;
  final bool isError;
  final List<Movie> movies;
  final String errorMessage;
  final int page;
  final bool isLoadMore;

  MovieState(
      {required this.errorMessage,
      required this.isError,
      required this.isLoad,
      required this.movies,
      required this.isLoadMore,
      required this.page});

  MovieState copyWith(
      {bool? isLoad,
      bool? isError,
      String? errorMessage,
      List<Movie>? movies,
      int? page,
      bool? isLoadMore}) {
    return MovieState(
        errorMessage: errorMessage ?? this.errorMessage,
        isError: isError ?? this.isError,
        isLoad: isLoad ?? this.isLoad,
        isLoadMore: isLoadMore ?? this.isError,
        page: page ?? this.page,
        movies: movies ?? this.movies);
  }
}
