// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'models/Pokemon.dart';
import 'TargetaPokemon.dart';

class GrillaTargetas extends StatelessWidget {
  const GrillaTargetas({Key? key, required this.listaPok}) : super(key: key);

  final List<Pokemon> listaPok;

  List<TargetaPokemon> cartasPok() {
    List<TargetaPokemon> cartas = [];
    for (var pok in listaPok) {
      TargetaPokemon carta = TargetaPokemon(pokemon: pok);
      cartas.add(carta);
    }
    return cartas;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: GridView.count(
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        crossAxisCount: 2,
        children: cartasPok(),
      ),
    );
  }
}
