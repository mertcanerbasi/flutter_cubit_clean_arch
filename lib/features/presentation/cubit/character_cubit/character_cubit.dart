import 'package:flutter_cubit_clean_arch/core/errors/failures.dart';
import 'package:flutter_cubit_clean_arch/features/data/repositories/character_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_cubit_clean_arch/features/data/models/character/character_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_state.dart';

@injectable
class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository repository;

  CharacterCubit({required this.repository}) : super(CharacterInitial());

  Future<void> fetchCharacters() async {
    emit(CharacterLoading());
    final failureOrCharacters = await repository.getCharacters();
    emit(failureOrCharacters.fold(
      (failure) => CharacterError(_mapFailureToMessage(failure)),
      (characters) => CharacterLoaded(characters: characters),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
