import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideShow_providers.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

//pass:06
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomButtomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
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
