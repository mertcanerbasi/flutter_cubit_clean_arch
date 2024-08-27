// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_cubit_clean_arch/core/utils/aes_encrypt/aes_encrypt.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:

@JsonSerializable(
  genericArgumentFactories: true,
)
class AesEncryptModel<T> {
  T data;

  AesEncryptModel({required this.data});

  static AesEncryptModel withMap(Map<String, dynamic> map) {
    return AesEncryptModel(data: jsonEncode(map));
  }

  factory AesEncryptModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _aesEncryptModelFromJson(json, fromJsonT);

  static AesEncryptModel<T> _aesEncryptModelFromJson<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      AesEncryptModel<T>(
        data: fromJsonT(jsonDecode(AesEncrypt.decrypt(json['data']))),
      );

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _aesEncryptModelToJson(this, toJsonT);

  Map<String, dynamic> _aesEncryptModelToJson(
    AesEncryptModel<T> instance,
    Object? Function(T value) toJsonT,
  ) =>
      <String, dynamic>{
        'data': AesEncrypt.encrypt(toJsonT(instance.data).toString()),
      };
}
