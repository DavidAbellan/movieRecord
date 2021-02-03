import 'package:flutter/material.dart';
import 'package:movie_records/src/providers/peliculas_provider.dart';
import 'package:movie_records/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  PeliculasProvider peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Records'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () => {})
        ],
      ),
      //SafeArea para que no se monte donde notch--> la bateria , el reloj,etc..
      // body: SafeArea(
      //child: Text('Hola Mundo'),
      body: Container(
        child: Column(
          children: <Widget>[_swiperTarjetas()],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    peliculasProvider.getEnCines();
    return CardSwiper(peliculas: ['Batman', 'robin', 'messi', 'suputamadre']);
  }
}
