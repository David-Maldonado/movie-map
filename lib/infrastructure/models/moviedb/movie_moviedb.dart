import 'package:intl/intl.dart';

class MovieMovieDb {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieMovieDb({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieMovieDb.fromJson(Map<String, dynamic> json) => MovieMovieDb(
        adult: json["adult"] ?? false, // Si no viene, va a ser false
        backdropPath: json["backdrop_path"] ??
            '', // Si es null, para que no explote se pone ''
        genreIds: json["genre_ids"] != null
            ? List<int>.from(json["genre_ids"].map((x) => x))
            : [], // Si es null, se asigna una lista vacía
        id: json["id"] ?? 0, // Valor predeterminado en caso de null
        originalLanguage: json["original_language"] ??
            '', // Valor predeterminado en caso de null
        originalTitle: json["original_title"] ??
            '', // Valor predeterminado en caso de null
        overview:
            json["overview"] ?? '', // Valor predeterminado en caso de null
        popularity: (json["popularity"]?.toDouble()) ??
            0.0, // Valor predeterminado en caso de null
        posterPath: json["poster_path"] ?? '', // Si es null, se pone ''
        releaseDate: _parseDate(json["release_date"]) ??
            DateTime.now(), // Manejo de fechas inválidas o null
        title: json["title"] ?? '', // Valor predeterminado en caso de null
        video: json["video"] ?? false, // Valor predeterminado en caso de null
        voteAverage: (json["vote_average"]?.toDouble()) ??
            0.0, // Valor predeterminado en caso de null
        voteCount:
            json["vote_count"] ?? 0, // Valor predeterminado en caso de null
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  static DateTime? _parseDate(String? date) {
    if (date == null || date.isEmpty)
      return null; // Manejo de null y cadena vacía
    try {
      // Ajusta el formato a tu formato esperado
      return DateFormat('yyyy-MM-dd').parse(date);
    } catch (e) {
      // Log o manejo del error de análisis si es necesario
      print("Date parsing error: $e");
      return null;
    }
  }
}

enum OriginalLanguage { EN, ES, HI, ZH }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "hi": OriginalLanguage.HI,
  "zh": OriginalLanguage.ZH
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
