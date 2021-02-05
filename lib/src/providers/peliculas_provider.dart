import 'dart:async';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  //Stream
  int _popularesPage = 0;

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

  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _procesarRespuesta(url);
  }

  Future<List<Movie>> getPopulares() async {
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

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
