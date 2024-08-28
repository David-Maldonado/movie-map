//abstacta porque no se quiere crear instancias de ella
//aqui se van a definir como lucen los origenes de datos (desde donde vengan moviedb, netflix, etc)
import 'package:moviemap/domain/entities/movie.dart';
//en domain se define como va a "lucir el datasource"
abstract class MoviesDatasource {
  //pass: 01
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpComming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<Movie> getMoviById(String idMovie);
}
