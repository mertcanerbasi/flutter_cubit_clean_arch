import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_clean_arch/core/di/dependency_injector.dart';
import 'package:flutter_cubit_clean_arch/features/presentation/cubit/character_cubit/character_cubit.dart';
import 'package:flutter_cubit_clean_arch/routes/app_router.dart';

@RoutePage()
class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters')),
      body: BlocProvider(
        create: (_) => getIt<CharacterCubit>()..fetchCharacters(),
        child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CharacterLoaded) {
              return ListView.builder(
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  final character = state.characters[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: character.image ?? '',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit
                              .cover, // Ensures the image covers the circle
                        ),
                      ),
                    ),
                    title: Text(character.name ?? ''),
                    subtitle: Text(character.status ?? ''),
                    onTap: () =>
                        context.router.push(DetailRoute(character: character)),
                  );
                },
              );
            } else if (state is CharacterError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
