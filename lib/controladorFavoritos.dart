// ignore_for_file: file_names

import 'package:proyecto_final/bd_prueba.dart';

import 'models/Pokemon.dart';

class ControladorFavoritos {
  static List<Pokemon> pokemonsAPI = [];
  static List<Pokemon> pokemonsFavoritos = [];

  setPokemonsAPI(List<Pokemon> pok) {
    pokemonsAPI = pok;
  }

  Future<void> actualizarFavoritos() async {
    pokemonsFavoritos = await Prueba().getPokemons();
  }

  List<Pokemon> getFavoritos() {
    actualizarFavoritos();
    return pokemonsFavoritos;
  }

  List<Pokemon> actualizarCartas() {
    actualizarFavoritos();
    List<Pokemon> newFavoritos = [];
    for (Pokemon pokemon in pokemonsAPI) {
      if (pokemonsFavoritos
          .where((element) => element.nombre == pokemon.nombre)
          .isNotEmpty) {
        if (pokemon.favorito !=
            pokemonsFavoritos
                .where((element) => element.nombre == pokemon.nombre)
                .first
                .favorito) {
          pokemon.changeFavorito();
        }
      } else {
        if (pokemon.favorito == true) {
          pokemon.changeFavorito();
        }
      }
      newFavoritos.add(pokemon);
    }

    pokemonsAPI = newFavoritos;

    return pokemonsAPI;
  }
}
