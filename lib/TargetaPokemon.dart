// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:proyecto_final/controladorFavoritos.dart';
import 'models/Pokemon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'bd_prueba.dart';
import 'VistaDetallada.dart';

class TargetaPokemon extends StatefulWidget {
  const TargetaPokemon({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _TargetaPokemonState createState() => _TargetaPokemonState();
}

class _TargetaPokemonState extends State<TargetaPokemon> {
  @override
  void initState() {
    super.initState();
    ControladorFavoritos().actualizarFavoritos();
  }

  void setFlag() {
    setState(() {
      widget.pokemon.changeFavorito();
      //LOGICA DE BASE DE DATOS
      if (widget.pokemon.favorito == true) {
        Prueba().addPokemon(widget.pokemon);
      } else {
        Prueba().removePokemon(widget.pokemon.nombre);
      }
      ControladorFavoritos().actualizarFavoritos();
    });
  }

  List<Text> getTipos(Pokemon pokemon) {
    List<Text> ttipos = [];
    for (var item in pokemon.tipos) {
      Text texto =
          Text(item.capitalize(), style: const TextStyle(color: Colors.black));
      ttipos.add(texto);
    }
    return ttipos;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Card(
          child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VistaDetallada(pokemon: widget.pokemon),
              ));
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.pokemon.nombre.capitalize(),
                  style: const TextStyle(color: Colors.black),
                ),
                IconButton(
                  constraints: const BoxConstraints(
                    maxWidth: 30,
                  ),
                  onPressed: () {
                    setFlag();
                  },
                  icon: Icon(
                    widget.pokemon.favorito
                        ? Icons.favorite
                        : Icons.favorite_outline_outlined,
                    color: Colors.red,
                  ),
                  color: Colors.red,
                ),
              ],
            ),
            Image.network(widget.pokemon.imagen),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getTipos(widget.pokemon),
            ),
          ],
        ),
      ));
    });
  }
}
