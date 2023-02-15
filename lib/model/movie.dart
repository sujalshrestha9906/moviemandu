class Movie {
  final String backdrop_path;
  final int id;
  final String poster_path;
  final String title;
  final String overview;
  final String release_date;
  final String vote_average;
  // final List genre_id;

  Movie({
    required this.backdrop_path,
    required this.id,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.title,
    required this.vote_average,
    // required this.genre_id
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      backdrop_path: json['backdrop_path'] ?? '',
      id: json['id'] ?? '',
      overview: json['overview'] ?? '',
      poster_path: json['poster_path'] ?? '',
      release_date: json['release_date'] ?? '',
      title: json['title'] ?? '',
      vote_average: '${json['vote_average']}',
      // genre_id: json['genre_id']
    );
  }
}
