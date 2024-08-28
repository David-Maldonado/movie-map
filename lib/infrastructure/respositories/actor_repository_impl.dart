import 'package:moviemap/domain/datasources/actors_datasource.dart';
import 'package:moviemap/domain/entities/actor.dart';
import 'package:moviemap/domain/repositories/actors_respository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;
  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActoresByMovie(String movieId) {
    return datasource.getActoresByMovie(movieId);
  }
}
