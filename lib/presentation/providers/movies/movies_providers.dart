import 'package:moviemap/domain/entities/movie.dart';
import 'package:moviemap/presentation/providers/movies/movies_respository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//pass: 05
//la clase que lo controla MoviesNotifier o para notificar, y la data que fluye es la List<Movie>
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies); //devuelve la instancia
});
final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //getPopular se llama la referencia, no se ejecuta ()
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies); //devuelve la instancia
});
final upcommingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //getPopular se llama la referencia, no se ejecuta ()
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComming;
  return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies); //devuelve la instancia
});
final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //getPopular se llama la referencia, no se ejecuta ()
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies); //devuelve la instancia
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  bool isLoading = false;
  int currentPage = 0;
  MovieCallBack fetchMoreMovies;
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(microseconds: 300));
    isLoading = false;
  }
}
