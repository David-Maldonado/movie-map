//abstacta porque no se quiere crear instancias de ella
//aqui se van a definir como lucen los origenes de datos (desde donde vengan moviedb, netflix, etc)
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDatasource {
 Future<List<Movie>> getNowPlaying({int page = 1});
}
