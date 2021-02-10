import 'dart:async';

import 'package:movie_records/src/models/actors_model.dart';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  //Stream
  int _popularesPage = 0;
  //cuando pagina la segunda página carga un monton de
  //llamadas http y consume datos , hay que controlarlo
  bool _cargando = false;

  List<Movie> _populares = new List();
  //broadcast para que se pueda escuchar en muchos lugares
  final _popularesStreamController = StreamController<List<Movie>>.broadcast();

  //introducir películas
  Function(List<Movie>) get popularesSink =>
      _popularesStreamController.sink.add;
  //escuchar peliculas
  Stream<List<Movie>> get popularesStream => _popularesStreamController.stream;

  String _apiKey = '80a1695fec74ccf4bb37c6b5c03ab6ee';
  String _language = 'es-ES';
  String _url = 'api.themoviedb.org';

  ///para cerrar los streams
  void disposeStreams() {
    _popularesStreamController?.close();
  }

  ///creamos un future para el casting en vez de stream
  ///porque es un número finito
  Future<List<Actor>> getCast(String peliculaID) async {
    final url = Uri.https(_url, '3/movie/$peliculaID/credits',
        {'api_key': _apiKey, 'language': _language});
    final res = await http.get(url);
    final decodedDta = json.decode(res.body);
    //'cast' es el nombre que le da al array moviedb
    final cast = new Cast.fromJsonList(decodedDta['cast']);
    return cast.actores;
  }

  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _procesarRespuesta(url);
  }

  Future<List<Movie>> buscarPelicula(String palabra) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': palabra});
    return await _procesarRespuesta(url);
  }

  Future<List<Movie>> getPopulares() async {
    //control de datos(cargando) para que no haga
    //mas peticiones de las necesarias

    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;

    return resp;
  }

  //optimización del código
  Future<List<Movie>> _procesarRespuesta(Uri url) async {
    final res = await http.get(url);
    final decodedData = json.decode(res.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.movies;
  }
}
