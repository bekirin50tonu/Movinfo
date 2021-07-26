// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeywordModel _$KeywordModelFromJson(Map<String, dynamic> json) {
  return KeywordModel(
    page: json['page'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalPages: json['total_pages'] as int?,
    totalResults: json['total_results'] as int?,
  );
}

Map<String, dynamic> _$KeywordModelToJson(KeywordModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    id: json['id'] as int?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
