//únicamente para trabajar con the moviedb, si tendremos otra fuente de datos crearemos otra clase especialmente.
import 'package:moviemap/config/constants/environment.dart';
import 'package:moviemap/infrastructure/mappers/movie_mapper.dart';
import 'package:moviemap/infrastructure/models/moviedb/movie_details.dart';
import 'package:moviemap/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';
import 'package:moviemap/domain/datasources/movies_datasource.dart';
import 'package:moviemap/domain/entities/movie.dart';

// acá se hacen los cambios y como van a lucir estàn en domain/datasource. aquì se implementan.

//pass:03
class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-PY'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') // solo si tiene posterPath o no lo pasa para mostrar y evitar mostrar la peli o errores posibles en el widget de image.
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMoviById(String idMovie) async {
    final response = await dio.get('/movie/$idMovie');
    if (response.statusCode != 200) {
      throw Exception('Película con el id: $idMovie no encontrada');
    }
    final movieDetails = MovieDetails.fromJson(response.data);
    //mapear el json y convertir/devolver un entity
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }
}
