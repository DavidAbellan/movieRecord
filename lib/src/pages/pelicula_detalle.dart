import 'package:flutter/material.dart';
import 'package:movie_records/src/models/actors_model.dart';
import 'package:movie_records/src/models/movie_model.dart';
import 'package:movie_records/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        //slivers es igual que children
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(pelicula),
            _descripcion(pelicula),
            _getCasting(pelicula)
          ]))
        ],
      ),
    );
  }

  Widget _getCasting(Movie pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        ;
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
        height: 200.0,
        child: PageView.builder(
          //pagesnapping para que no vaya a perchones
          pageSnapping: false,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1,
          ),
          itemCount: actores.length,

          itemBuilder: (context, i) {
            return _actorCard(actores[i]);
          }, //_actorCard(actores[i]),
        ));
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: [
          Text(actor.character, overflow: TextOverflow.ellipsis),
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  height: 150.0,
                  placeholder: AssetImage('assets/img/loadingactor.gif'),
                  image: NetworkImage(actor.getPhoto())))
        ],
      ),
    );
  }

  Widget _posterTitulo(Movie pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
              tag: pelicula.id,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: NetworkImage(pelicula.getPosterImg()),
                    height: 150.0,
                  ))),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pelicula.originalTitle,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(pelicula.title),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString())
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Movie pel) {
    return Container(
      child: Text(
        pel.overview,
        textAlign: TextAlign.justify,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    );
  }

  Widget _crearAppBar(Movie pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          background: FadeInImage(
              image: NetworkImage(pelicula.getBackdrop()),
              placeholder: AssetImage('assets/img/loadingDetail.gif'),
              fadeInDuration: Duration(seconds: 2),
              fit: BoxFit.cover),
          centerTitle: true,
          title: Text(pelicula.title,
              style: TextStyle(color: Colors.white, fontSize: 16.0))),
    );
  }
}
