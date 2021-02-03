// Generated by https://quicktype.io

class Peliculas {
  List<Movie> movies = new List();
  Peliculas();
  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final pelicula = new Movie.fromJsonMap(item);
        movies.add(pelicula);
      }
    }
  }
}

class Movie {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  //he creado esta clase copiando la respuesta raw del servidor
  //command palette/ paste Json as code
  //por lo se hace necesario aludir a como vienen los campos nombrados
  //en el servidor porque automáticamente les cambia la nomenclatura
  //(capitaliza y quita _)
  //ej : vote_average = voteAverage
  //de ahí que tenga que hacer este Movie.fromJsonMap
  Movie.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
  }
  //dividimos popularity y voteaverage por si nos respondiera
  //la api con un int siendo double
}