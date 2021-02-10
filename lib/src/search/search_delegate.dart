import 'package:flutter/material.dart';
import 'package:movie_records/src/models/movie_model.dart';
import 'package:movie_records/src/providers/peliculas_provider.dart';

//todos los buscadores son iguales
class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones de nuestro AppBar

    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => {query = ''})
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del Appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados que vamos a mostrar
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data.map((e) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(e.getPosterImg()),
                  placeholder: AssetImage('assets/img/noPhoto.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(e.title),
                subtitle: Text(e.originalTitle),
                onTap: () {
                  close(context, null);
                  //uniqueId lo enviamos vacío para que no pete
                  e.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: e);
                },
              );
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
