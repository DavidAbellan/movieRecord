import '../models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apiKey = '80a1695fec74ccf4bb37c6b5c03ab6ee';
  String _language = 'es-ES';
  String _url = 'api.themoviedb.org';
  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    final res = await http.get(url);
    final decodedData = json.decode(res.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.movies;
  }
}
