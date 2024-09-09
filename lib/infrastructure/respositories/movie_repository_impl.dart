//llamar el datasource
import 'package:moviemap/domain/datasources/movies_datasource.dart';
import 'package:moviemap/domain/entities/movie.dart';
import 'package:moviemap/domain/repositories/movies_respository.dart';

class MovieRepositoryImpl extends MoviesRespository {
  late final MoviesDatasource datasource;
  MovieRepositoryImpl(
      this.datasource); //posicional porque recibe 1, si fueran más se recomienda por nombre.

  //pass:04
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page = 1);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page = 1);
  }

  @override
  Future<List<Movie>> getUpComming({int page = 1}) {
    return datasource.getUpComming(page: page = 1);
  }

  @override
  Future<Movie> getMoviById(String idMovie) {
    return datasource.getMoviById(idMovie);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }
}
