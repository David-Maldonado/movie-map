import 'package:flutter/material.dart';
import 'package:moviemap/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';
import 'package:moviemap/presentation/delegates/seach_movie_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviemap/presentation/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
        color: colors.primary, fontWeight: FontWeight.w500, letterSpacing: 1.5);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.movie_filter_outlined,
                  color: colors.primary,
                  size: 27.5,
                ),
                const SizedBox(width: 5),
              ],
            ),
            Text(
              'Cinema Explorer',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            IconButton(
              onPressed: () async {
                final movieRepository = ref.read(movieRepositoryProvider);

                // Ejecutar la búsqueda y obtener el resultado antes de interactuar con el context
                final movie = await showSearch<Movie?>(
                  context: context,
                  delegate: SeachMovieDelegate(
                    searchMovies: movieRepository.searchMovies,
                  ),
                );

                // Asegurarse de que el contexto sigue siendo válido y la película no es nula
                if (movie != null && context.mounted) {
                  // Navegar usando el contexto solo si está montado
                  context.push('/movie/${movie.id}');
                }
              },
              icon: Icon(
                Icons.search_outlined,
                color: colors.primary,
                size: 27.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
