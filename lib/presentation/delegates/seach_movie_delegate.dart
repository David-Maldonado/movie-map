import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:moviemap/config/helpers/human_formats.dart';
import 'package:moviemap/domain/entities/movie.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SeachMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack searchMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debouncerTimer;

  SeachMovieDelegate({required this.searchMovies});

  void clearStreams() {
    debounceMovies.close();
  }

  void _onQueryChanged(String query) {
    // Verificar si _debouncerTimer no es null antes de llamar a .isActive
    if (_debouncerTimer != null && _debouncerTimer!.isActive) {
      _debouncerTimer!.cancel();
    }

    _debouncerTimer = Timer(const Duration(milliseconds: 200), () async {
      if (query.isEmpty) {
        debounceMovies.add([]);
        return;
      }
      final movies = await searchMovies(query);

      debounceMovies.add(movies);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // query es propio del delegate, es el texto de la busqueda
      if (query.isNotEmpty)
        FadeIn(
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
        // future: searchMovies(query),
        stream: debounceMovies.stream,
        builder: (context, snapshot) {
          // print('Realizando petición');
          final movies = snapshot.data ?? [];
          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _MovieItem(
                  movie: movies[index],
                  onMovieSelected: (context,movie) {
                    clearStreams();
                    close(context, movie);
                  },
                );
              });
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            //description
            const SizedBox(width: 10),

            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.bodyMedium!
                              .copyWith(color: Colors.yellow.shade900))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
