import 'package:flutter/material.dart';

class ActList extends StatelessWidget {
  const ActList({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de bandas ordenadas alfabeticamente
    final List<String> bandas = [
      'Iron Maiden',
      'Led Zeppelin',
      'Metallica'
    ]..sort((a, b) => a.compareTo(b)); // Ordenação alfabética

    return ListView.builder(
      itemCount: bandas.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            bandas[index],
            style: const TextStyle(fontStyle: FontStyle.italic), // Fonte em itálico
          ),
        );
      },
    );
  }
}
