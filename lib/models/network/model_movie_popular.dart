class ModelMoviePopular {
  ModelMoviePopular({
    this.results,
  });

  ModelMoviePopular.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(ModelMovie.fromJson(v));
      });
    }
  }

  List<ModelMovie>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ModelMovie {
  ModelMovie(
      {this.backdropPath,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.voteAverage,
      this.id});

  ModelMovie.fromJson(dynamic json) {
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    voteAverage = json['vote_average'];
    id = json['id'];
  }

  String? backdropPath;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  num? voteAverage;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backdrop_path'] = backdropPath;
    map['overview'] = overview;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['title'] = title;
    map['vote_average'] = voteAverage;
    map['id'] = id;
    return map;
  }
}
