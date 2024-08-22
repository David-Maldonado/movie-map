import 'package:cinemapedia/domain/entities/movie.dart';

//los repository son los que van a llamar al datasource
// el datasource no lo llamamos de forma directa, sino a traves del respository porque este nos va a ayudar de datasource de ser necesario.
abstract class MoviesRespository {
  //pass: 02
 Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpComming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
}
