part of 'character_cubit.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterModel> characters;
  CharacterLoaded({required this.characters});
}

class CharacterError extends CharacterState {
  final String message;
  CharacterError(this.message);
}
