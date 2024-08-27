import 'package:dio/dio.dart';
import 'package:flutter_cubit_clean_arch/features/data/models/base_model/base_model.dart';
import 'package:flutter_cubit_clean_arch/features/data/models/character/character_model.dart';
import 'package:retrofit/retrofit.dart';

part 'character_api_service.g.dart';

@RestApi()
abstract class CharacterApiService {
  factory CharacterApiService(Dio dio) = _CharacterApiService;

  @GET("/character")
  Future<BaseModel<CharacterModel>> getCharacters();
}
