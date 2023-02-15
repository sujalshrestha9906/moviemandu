import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviemandu/model/movie_state.dart';
import 'package:moviemandu/services/movie_service.dart';

import '../api.dart';

final defaultState = MovieState(
    errorMessage: '',
    isError: false,
    isLoad: false,
    movies: [],
    isLoadMore: false,
    page: 1);

final searchProvider =
    StateNotifierProvider.autoDispose<SearchMovie, MovieState>(
        (ref) => SearchMovie(defaultState));

class SearchMovie extends StateNotifier<MovieState> {
  SearchMovie(super.state) {}

  Future<void> searchMovie(String searchText) async {
    state = state.copyWith(isLoad: true, isError: false);
    final response = await MovieService.getSearchMovie(searchText: searchText);
    response.fold((l) {
      state = state.copyWith(isLoad: false, isError: true, errorMessage: l);
    }, (r) {
      state = state.copyWith(isLoad: false, isError: false, movies: r);
    });
  }
}
