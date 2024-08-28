import 'package:moviemap/domain/entities/actor.dart';

abstract class ActorsRepository {
  //pass: 02
  Future<List<Actor>> getActoresByMovie(String movieId);
}
