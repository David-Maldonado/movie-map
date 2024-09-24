import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviemap/presentation/providers/movies/initial_loading_provider.dart';
import 'package:moviemap/presentation/providers/movies/movies_providers.dart';
import 'package:moviemap/presentation/providers/movies/movies_slideShow_providers.dart';
import 'package:moviemap/presentation/widgets/movies/movies_horizontal_listview.dart';
import 'package:moviemap/presentation/widgets/movies/movies_slideshow.dart';
import 'package:moviemap/presentation/widgets/shared/custom_appbar.dart';
import 'package:moviemap/presentation/widgets/shared/full_screen_loader.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView();

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    //read lee
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcommingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FlullScreenLoader();

    //watch queda pendiente del estado
    final sliceShowMovies = ref.watch(movieSildeShowProvider);

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcommingMovies = ref.watch(upcommingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(children: [
            // const CustomAppbar(),
            MoviesSlideShow(movies: sliceShowMovies),
            MoviesHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cartelera',
              subTitle: 'Disfruta en el cine',
              loadNextPage: () {
                //read solo lee y dentro de una funcion para cuando se ejecutre, el watch esta al pendiente.
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListview(
              movies: upcommingMovies,
              title: 'Próximamente',
              subTitle: 'Pronto en pantalla',
              loadNextPage: () {
                //read solo lee y dentro de una funcion para cuando se ejecutre, el watch esta al pendiente.
                ref.read(upcommingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListview(
              movies: topRatedMovies,
              title: 'Destacadas',
              subTitle: 'Las aclamadas',
              loadNextPage: () {
                //read solo lee y dentro de una funcion para cuando se ejecutre, el watch esta al pendiente.
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              subTitle: 'Éxitos taquilleros',
              loadNextPage: () {
                //read solo lee y dentro de una funcion para cuando se ejecutre, el watch esta al pendiente.
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(height: 15)
          ]);
        }, childCount: 1))
      ],
    );
  }
}
