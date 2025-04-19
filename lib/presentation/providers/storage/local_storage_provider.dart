import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviemap/infrastructure/datasources/isar_datasource.dart';
import 'package:moviemap/infrastructure/respositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
