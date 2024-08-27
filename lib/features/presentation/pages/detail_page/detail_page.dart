import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit_clean_arch/features/data/models/character/character_model.dart';

@RoutePage()
class DetailPage extends StatelessWidget {
  final CharacterModel character;
  const DetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  character.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(character.name ?? ''),
            subtitle: Text(character.status ?? ''),
          ),
          ListTile(
            title: Text('Species: ${character.species ?? ''}'),
          ),
          ListTile(
            title: Text("Gender: ${character.gender ?? ''}"),
          )
        ],
      ),
    );
  }
}
