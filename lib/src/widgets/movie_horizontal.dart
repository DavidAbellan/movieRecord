import 'package:flutter/material.dart';
import 'package:movie_records/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> peliculas;
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  //paginación , crear un lstener
  final Function siguientePagina;

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.25);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    //paginacion
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });
    return Container(
      height: _screenSize.height * 0.2,
      //la diferencia entre Pageview y Pageview.builder
      //el builder carga solo cuando es necesario
      child: PageView.builder(
        controller: _pageController,

        pageSnapping: false,
        //children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, i) {
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Movie e) {
    e.uniqueId = '${e.id}-horizontal';
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
              tag: e.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/img/g0RC.gif'),
                    image: NetworkImage(e.getPosterImg())),
              )),
          Text(
            e.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    //retornamos este widget para controlar
    //la interacción con la tarjeta del usuario
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: e);
      },
      child: tarjeta,
    );
  }

  List<Widget> _tarjetas(context) {
    var tarjetas = peliculas.map((e) {
      return Container(
        height: 80.0,
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    height: 130,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/img/g0RC.gif'),
                    image: NetworkImage(e.getPosterImg())),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                e.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        )),
      );
    }).toList();
    return tarjetas;
  }
}
