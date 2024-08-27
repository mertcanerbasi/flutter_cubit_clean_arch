import 'package:json_annotation/json_annotation.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  int? id;

  String? name;

  String? status;

  String? species;

  String? type;

  String? gender;

  LocationModel? origin;

  LocationModel? location;

  String? image;

  List<String>? episode;

  String? url;

  DateTime? created;

  CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}

@JsonSerializable()
class LocationModel {
  String? name;
  String? url;

  LocationModel({
    this.name,
    this.url,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
