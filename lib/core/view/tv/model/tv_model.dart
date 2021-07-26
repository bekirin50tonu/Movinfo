import 'package:json_annotation/json_annotation.dart';
import 'package:movinfo/core/base/base_model.dart';

part 'tv_model.g.dart';

@JsonSerializable()
class TVModel extends BaseModel {
  int? page;
  List<Results>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  TVModel({this.page, this.results, this.totalPages, this.totalResults});

  Map<String, dynamic> toJson() {
    return _$TVModelToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$TVModelFromJson(json);
  }
}

@JsonSerializable()
class Results {
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;
  int? id;
  String? name;
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'original_name')
  String? originalName;
  String? overview;
  double? popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;

  Results(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteAverage,
      this.voteCount});

  factory Results.fromJson(Map<String, dynamic> json) {
    return _$ResultsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResultsToJson(this);
  }
}
