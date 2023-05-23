import 'package:flutter/material.dart';
import 'package:proyecto_final/controladorFavoritos.dart';
import 'models/Pokemon.dart';
import 'GrillaTargetas.dart';

class Vistas {
  ControladorFavoritos controlador = ControladorFavoritos();

  Vistas(List<Pokemon> pokemonsAPI) {
    controlador.setPokemonsAPI(pokemonsAPI);
  }

  Center getView(int index) {
    Center retorno = getListaPok();

    switch (index) {
      case 0:
        retorno = getListaPok();
        break;

      case 1:
        retorno = getFavoritos();
        break;
    }

    return retorno;
  }

  Center getFavoritos() {
    bool flag = true;
    if (controlador.getFavoritos().isNotEmpty) {
      flag = false;
    }
    return Center(
      child: flag
          ? const Text("NO HAY POKEMONS FAVORITOS AÚN")
          : GrillaTargetas(listaPok: controlador.getFavoritos()),
    );
  }

  Center getListaPok() {
    return Center(
      child: GrillaTargetas(
        listaPok: controlador.actualizarCartas(),
      ),
    );
  }

/*
  Card getCarta(String nombre, Image imagen, List<String> tipos) {
    List<Text> ttipos = [];

    for (var item in tipos) {
      Text texto = Text(item, style: const TextStyle(color: Colors.black));
      ttipos.add(texto);
    }

    return Card(
        child: ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.white),
      ),
      onPressed: () {},
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nombre,
                style: const TextStyle(color: Colors.black),
              ),
              IconButton(
                constraints: const BoxConstraints(
                  maxWidth: 30,
                ),
                onPressed: () {},
                icon: const Icon(Icons.favorite_outline_outlined),
                color: Colors.red,
              ),
            ],
          ),
          imagen,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ttipos,
          ),
        ],
      ),
    ));
  }

  Container prueba(List<Pokemon> pokemons) {
    List<Card> cartas = [];

    for (var item in pokemons) {
      Card carta = getCarta(item.nombre, item.imagen, item.tipos);
      cartas.add(carta);
    }

    return Container(
      padding: const EdgeInsets.all(15),
      child: GridView.count(
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        crossAxisCount: 2,
        children: cartas,
      ),
    );
  }*/
}
