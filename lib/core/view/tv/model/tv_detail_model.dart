import 'package:json_annotation/json_annotation.dart';
import 'package:movinfo/core/base/base_model.dart';

part 'tv_detail_model.g.dart';

@JsonSerializable()
class TVDetailModel extends BaseModel {
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @JsonKey(name: "created_by")
  List<CreatedBy>? createdBy;
  @JsonKey(name: "episode_run_time")
  List<int>? episodeRunTime;
  @JsonKey(name: "first_air_date")
  String? firstAirDate;
  List<Genres>? genres;
  String? homepage;
  int? id;
  @JsonKey(name: "in_production")
  bool? inProduction;
  List<String>? languages;
  @JsonKey(name: "last_air_date")
  String? lastAirDate;
  @JsonKey(name: "last_episode_to_air")
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  List<Networks>? networks;
  @JsonKey(name: "number_of_episodes")
  int? numberOfEpisodes;
  @JsonKey(name: "number_of_seasons")
  int? numberOfSeasons;
  @JsonKey(name: "origin_country")
  List<String>? originCountry;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "original_name")
  String? originalName;
  String? overview;
  double? popularity;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "production_companies")
  List<ProductionCompanies>? productionCompanies;
  @JsonKey(name: "production_countries")
  List<ProductionCountries>? productionCountries;
  List<Seasons>? seasons;
  @JsonKey(name: "spoken_languages")
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "vote_count")
  int? voteCount;

  TVDetailModel(
      {this.backdropPath,
      this.createdBy,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.homepage,
      this.id,
      this.inProduction,
      this.languages,
      this.lastAirDate,
      this.lastEpisodeToAir,
      this.name,
      this.networks,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.seasons,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.type,
      this.voteAverage,
      this.voteCount});

  Map<String, dynamic> toJson() {
    return _$TVDetailModelToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$TVDetailModelFromJson(json);
  }
}

@JsonSerializable()
class ProductionCompanies {
  int? id;
  @JsonKey(name: 'logo_path')
  String? logoPath;
  String? name;
  @JsonKey(name: 'origin_country')
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) {
    return _$ProductionCompaniesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductionCompaniesToJson(this);
  }
}

@JsonSerializable()
class CreatedBy {
  int? id;
  @JsonKey(name: 'credit_id')
  String? creditId;
  String? name;
  int? gender;
  @JsonKey(name: 'profile_path')
  String? profilePath;

  CreatedBy({this.id, this.creditId, this.name, this.gender, this.profilePath});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return _$CreatedByFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreatedByToJson(this);
  }
}

@JsonSerializable()
class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return _$GenresFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GenresToJson(this);
  }
}

@JsonSerializable()
class LastEpisodeToAir {
  @JsonKey(name: 'air_date')
  String? airDate;
  @JsonKey(name: 'episode_number')
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  @JsonKey(name: 'production_code')
  String? productionCode;
  @JsonKey(name: 'season_number')
  int? seasonNumber;
  @JsonKey(name: 'still_path')
  String? stillPath;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;

  LastEpisodeToAir(
      {this.airDate,
      this.episodeNumber,
      this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    return _$LastEpisodeToAirFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LastEpisodeToAirToJson(this);
  }
}

@JsonSerializable()
class Networks {
  String? name;
  int? id;
  @JsonKey(name: 'logo_path')
  String? logoPath;
  @JsonKey(name: 'origin_country')
  String? originCountry;

  Networks({this.name, this.id, this.logoPath, this.originCountry});

  factory Networks.fromJson(Map<String, dynamic> json) {
    return _$NetworksFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NetworksToJson(this);
  }
}

@JsonSerializable()
class ProductionCountries {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  factory ProductionCountries.fromJson(Map<String, dynamic> json) {
    return _$ProductionCountriesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductionCountriesToJson(this);
  }
}

@JsonSerializable()
class Seasons {
  @JsonKey(name: 'air_date')
  String? airDate;
  @JsonKey(name: 'episode_count')
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'season_number')
  int? seasonNumber;

  Seasons(
      {this.airDate,
      this.episodeCount,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber});

  factory Seasons.fromJson(Map<String, dynamic> json) {
    return _$SeasonsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SeasonsToJson(this);
  }
}

@JsonSerializable()
class SpokenLanguages {
  @JsonKey(name: 'english_name')
  String? englishName;
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) {
    return _$SpokenLanguagesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SpokenLanguagesToJson(this);
  }
}
