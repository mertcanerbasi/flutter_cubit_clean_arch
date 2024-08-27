// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CharacterPage]
class CharacterRoute extends PageRouteInfo<void> {
  const CharacterRoute({List<PageRouteInfo>? children})
      : super(
          CharacterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CharacterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CharacterPage();
    },
  );
}

/// generated route for
/// [DetailPage]
class DetailRoute extends PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    Key? key,
    required CharacterModel character,
    List<PageRouteInfo>? children,
  }) : super(
          DetailRoute.name,
          args: DetailRouteArgs(
            key: key,
            character: character,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailRouteArgs>();
      return DetailPage(
        key: args.key,
        character: args.character,
      );
    },
  );
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.character,
  });

  final Key? key;

  final CharacterModel character;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, character: $character}';
  }
}
