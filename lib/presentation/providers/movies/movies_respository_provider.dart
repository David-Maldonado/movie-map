import 'package:moviemap/infrastructure/datasources/moviedb_datasource.dart';
import 'package:moviemap/infrastructure/respositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// este repositorio es inmutable, en provider encargado de proveer a los otros provider lo que se obtiene aquì
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
