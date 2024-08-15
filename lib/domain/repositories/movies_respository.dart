import 'package:cinemapedia/domain/entities/movie.dart';

//los repository son los que van a llamar al datasource
// el datasource no lo llamamos de forma directa, sino a traves del respository porque este nos va a ayudar de datasource de ser necesario.
abstract class MoviesRespository {
 Future<List<Movie>> getNowPlaying({int page = 1});
}
