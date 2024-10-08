//leer varios modelos y crear la entidad, es su objetivo.

import 'package:moviemap/domain/entities/movie.dart';
import 'package:moviemap/infrastructure/models/moviedb/movie_details.dart';
import 'package:moviemap/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg?w=740',
      genreIds: moviedb.genreIds
          .map((e) => e.toString())
          .toList(), //convertir los int en string
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: moviedb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg?w=740',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg?w=740',
      genreIds: moviedb.genres
          .map((e) => e.name)
          .toList(), //convertir los int en string
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: moviedb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg?w=740',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
