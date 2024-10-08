import 'package:dio/dio.dart';
import 'package:moviemap/config/constants/environment.dart';
import 'package:moviemap/domain/datasources/actors_datasource.dart';
import 'package:moviemap/domain/entities/actor.dart';
import 'package:moviemap/infrastructure/mappers/actor_mapper.dart';
import 'package:moviemap/infrastructure/models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-PY'
      }));

  @override
  Future<List<Actor>> getActoresByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
