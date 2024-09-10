import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviemap/domain/entities/movie.dart';
import 'package:moviemap/presentation/delegates/seach_movie_delegate.dart';
import 'package:moviemap/presentation/providers/providers.dart';

//un provider -- una manera de hacerlo
final searchQueryProvider = StateProvider<String>((ref) => '');
//otro provider - otra manera de hacerlo
final searchyMoviesProvider =
    StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchMoviesNotifier(
      ref: ref, searchMovies: movieRepository.searchMovies);
});

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);


class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallBack searchMovies;
  final Ref ref;
  SearchMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
