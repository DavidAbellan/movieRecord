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
      padding: EdgeInsets.only(top: 3.0),
      //double.infinity para que ocupe todo lo que pueda
      //width: double.infinity,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.50,
        itemBuilder: (BuildContext context, int index) {
          //cuando hacemos tap en populares o en principal vamos a detalle
          //pero falla cuando está la misma película si ambos están  la misma
          //página, por eso vamos a crear un uniqueId
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          //ClipRRect para bordes redondeados
          return Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'detalle',
                            arguments: peliculas[index]);
                      },
                      child: FadeInImage(
                        placeholder: AssetImage('assets/img/g0RC.gif'),
                        fit: BoxFit.cover,
                        image: NetworkImage(peliculas[index].getPosterImg()),
                      ))));
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
