import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_records/src/models/movie_model.dart';

//api key :  80a1695fec74ccf4bb37c6b5c03ab6ee

class CardSwiper extends StatelessWidget {
  final List<Movie> peliculas;

  ///constructor
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    //media query para saber las dimensiones del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    //rodeamos a Swiper con un container
    //porque hay que definir unas dimensiones
    //(width,height) que necesita para su visualización
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      //double.infinity para que ocupe todo lo que pueda
      //width: double.infinity,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          //ClipRRect para bordes redondeados
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/g0RC.gif'),
                fit: BoxFit.cover,
                image: NetworkImage(peliculas[index].getPosterImg()),
              ));
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
