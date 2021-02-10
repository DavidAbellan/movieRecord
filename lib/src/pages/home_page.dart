import 'package:flutter/material.dart';
import 'package:movie_records/src/providers/peliculas_provider.dart';
import 'package:movie_records/src/search/search_delegate.dart';
import 'package:movie_records/src/widgets/card_swiper_widget.dart';
import 'package:movie_records/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  PeliculasProvider peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Records'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: DataSearch() /*query: 'Busca'*/);
              })
        ],
      ),
      //SafeArea para que no se monte donde notch--> la bateria , el reloj,etc..
      // body: SafeArea(
      //child: Text('Hola Mundo'),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          //loading
          return Container(
            child: Center(child: CircularProgressIndicator()),
            height: 400.0,
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 1.0,
          ),
          //FutureBuilder solo escucha una vez
          //streambuilder se queda a la escucha
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
