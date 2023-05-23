// ignore_for_file: file_names, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'controladorFavoritos.dart';
import 'models/Pokemon.dart';
import 'bd_prueba.dart';

class VistaDetallada extends StatefulWidget {
  const VistaDetallada({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _VistaDetalladaState createState() => _VistaDetalladaState();
}

class _VistaDetalladaState extends State<VistaDetallada> {
  List<Text> getInfo(String info) {
    late var datos;
    switch (info) {
      case "habilidades":
        datos = widget.pokemon.habilidades;
        break;
      case "tipos":
        datos = widget.pokemon.tipos;
        break;
    }
    List<Text> informacion = [];
    for (String item in datos) {
      Text texto = Text(
        item.capitalize(),
        style: const TextStyle(fontSize: 18),
      );
      informacion.add(texto);
    }
    return informacion;
  }

  Center getStats() {
    List<Text> estadisticas = [
      const Text(
        "Estadisticas Base",
        style: TextStyle(fontSize: 20),
      )
    ];
    for (Estadistica stat in widget.pokemon.estadisticas) {
      Text texto = Text(
        "${stat.nombre.capitalize()}: ${stat.valorBase}",
        style: const TextStyle(fontSize: 18),
      );
      estadisticas.add(texto);
    }

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: estadisticas,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("POKEDEX"),
          backgroundColor: Colors.red,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nombre: ${widget.pokemon.nombre.capitalize()}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.pokemon.changeFavorito();
                        if (widget.pokemon.favorito == true) {
                          Prueba().addPokemon(widget.pokemon);
                        } else {
                          Prueba().removePokemon(widget.pokemon.nombre);
                        }
                        ControladorFavoritos().actualizarFavoritos();
                      });
                    },
                    icon: Icon(widget.pokemon.favorito
                        ? Icons.favorite
                        : Icons.favorite_outline_outlined),
                    color: Colors.red,
                    iconSize: 50,
                  )
                ],
              ),
              Image.network(
                widget.pokemon.imagen,
                height: 300,
                fit: BoxFit.fitHeight,
              ),
              const Center(
                  child: Text(
                "Tipos",
                style: TextStyle(fontSize: 20),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: getInfo("tipos"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Altura: ${widget.pokemon.altura} m",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Peso: ${widget.pokemon.peso} kg",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                "Habilidades",
                style: TextStyle(fontSize: 20),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: getInfo("habilidades"),
              ),
              const SizedBox(
                height: 20,
              ),
              getStats(),
            ],
          ),
        ),
      ),
    );
  }
}
