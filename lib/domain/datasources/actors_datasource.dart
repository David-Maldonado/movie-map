//recordar que es una definición y no la implement
import 'package:moviemap/domain/entities/actor.dart';

//pass: 01

abstract class ActorsDatasource {
  Future<List<Actor>> getActoresByMovie(String movieId);
}
