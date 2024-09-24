import 'package:moviemap/presentation/views/movies/favorites_view.dart';
import 'package:moviemap/presentation/views/movies/home_view.dart';
import 'package:moviemap/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../views/movies/categories_view.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoriesView(), // categorias
    FavoritesView()
  ];
//pass:06
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: HomeView(), // indexedstack muy bueno para conservar los estados de la vista (ir y volver del screen y todo siga igual)
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomButtomNavigation(
        currentIndex: pageIndex,
      ),
    );
  }
}
