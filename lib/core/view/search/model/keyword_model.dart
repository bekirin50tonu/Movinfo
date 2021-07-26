import 'package:json_annotation/json_annotation.dart';
import 'package:movinfo/core/base/base_model.dart';

part 'keyword_model.g.dart';

@JsonSerializable()
class KeywordModel extends BaseModel {
  int? page;
  List<Results>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  KeywordModel({this.page, this.results, this.totalPages, this.totalResults});

  Map<String, dynamic> toJson() {
    return _$KeywordModelToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$KeywordModelFromJson(json);
  }
}

@JsonSerializable()
class Results {
  int? id;
  String? name;

  Results({this.id, this.name});

  factory Results.fromJson(Map<String, dynamic> json) {
    return _$ResultsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResultsToJson(this);
  }
}
