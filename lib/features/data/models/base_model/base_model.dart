import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseModel<T> {
  Info? info;
  List<T>? results;

  BaseModel({
    this.info,
    this.results,
  });

  factory BaseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$BaseModelToJson(this, toJsonT);
}

@JsonSerializable()
class Info {
  int? count;
  int? pages;
  String? next;
  String? prev;

  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
