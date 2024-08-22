import 'package:moviemap/config/helpers/human_formats.dart';
import 'package:moviemap/domain/entities/movie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListview> createState() =>
      _MoviesHorizontalListviewState();
}

// al ser un statefulWiget, se hacen referencia al widget porque aquí es el state y se hace referecia al widget definido arriba.
class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

// al haber un listener y saber que la pantalla se va a "destruir" hay que hacer el dispose del mismo.
  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //sizebox para que no se desborde, o sea, tener tamaños fijos
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Tile(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics:
                  const BouncingScrollPhysics(), //así tanto en ios y android van a tener el mismo "efecto"
              itemBuilder: (BuildContext context, int index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen
          SizedBox(
            width: 150,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath,
                    width: 150, fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  return FadeIn(child: child);
                }),
              ),
            ),
          ),
          const SizedBox(height: 5),
          //* Title
          SizedBox(
            width: 150,
            child: Text(
              '${movie.title}\n',
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
          //*Rating

          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: Colors.yellow.shade800,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '${movie.voteAverage}',
                  //copywitgh copia todo lo de bodyMedium y te permite sobreescribir
                  style: textStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const Spacer(),
                const Icon(Icons.remove_red_eye_outlined, size: 20),
                const SizedBox(width: 3),
                Text(HumanFormats.number(movie.popularity),
                    style: textStyle.bodySmall)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Tile({this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      //para que los bordes no queden pegados a los costados
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          //para haga un espacio, aqui horizontal al ser row
          const Spacer(),

          if (subTitle != null)
            FilledButton(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!))
        ],
      ),
    );
  }
}
