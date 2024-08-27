import 'package:dartz/dartz.dart';
import 'package:flutter_cubit_clean_arch/core/errors/failures.dart';
import 'package:flutter_cubit_clean_arch/features/data/api/character_api_service.dart';
import 'package:flutter_cubit_clean_arch/features/data/models/character/character_model.dart';
import 'package:injectable/injectable.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterModel>>> getCharacters();
}

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterApiService _apiService;

  CharacterRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, List<CharacterModel>>> getCharacters() async {
    try {
      final characters = await _apiService.getCharacters();
      if (characters.results != null) {
        return Right(characters.results!);
      } else {
        return Left(DatabaseFailure("No characters found"));
      }
    } catch (e) {
      return Left(ServerFailure("Failed to load characters"));
    }
  }
}
