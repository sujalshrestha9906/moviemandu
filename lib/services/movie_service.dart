import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:moviemandu/model/movie.dart';

import '../api.dart';
import '../constants/constant.dart';
import '../exceptions/api_exception.dart';

class MovieService {
  static final dio = Dio();
  static Future<Either<String, List<Movie>>> getMovieByCategory(
      {required String api, required int page}) async {
    try {
      final response = await dio
          .get(api, queryParameters: {'api_key': apiKey, 'page': page});
      final data = (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();

      return Right(data);
    } on DioError catch (err) {
      return Left(DioException.getDioError(err));
    }
  }

  static Future<Either<String, List<Movie>>> getSearchMovie(
      {required String searchText}) async {
    try {
      final response = await dio.get(Api.searchMovie,
          queryParameters: {'api_key': apiKey, 'query': searchText});

      if ((response.data['results'] as List).isEmpty) {
        return Left('Try another keyword!!!');
      } else {
        final data = (response.data['results'] as List)
            .map((e) => Movie.fromJson(e))
            .toList();
        return Right(data);
      }
    } on DioError catch (err) {
      return Left(DioException.getDioError(err));
    }
  }
}
