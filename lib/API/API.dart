// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/Pokemon.dart';

class API {
  Future<List<Pokemon>> getAPI(int cantidad) async {
    List<Pokemon> pokemons = [];

    for (int i = 2; i < cantidad + 2; i++) {
      String urlAPI = "https://pokeapi.co/api/v2/pokemon/$i";
      var url = Uri.parse(urlAPI);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        String nombre = jsonData["name"];
        List<String> habilidades = [];
        for (var item in jsonData["abilities"]) {
          habilidades.add(item["ability"]["name"]);
        }
        int altura = jsonData["height"];
        String imagen = jsonData["sprites"]["front_default"];
        List<String> tipos = [];
        for (var item in jsonData["types"]) {
          tipos.add(item["type"]["name"]);
        }
        List<Estadistica> estadisticas = [];
        for (var item in jsonData["stats"]) {
          estadisticas
              .add(Estadistica(item["stat"]["name"], item["base_stat"]));
        }

        int peso = jsonData["weight"];

        Pokemon pokemon = Pokemon(
            nombre, habilidades, altura, imagen, tipos, estadisticas, peso);
        pokemons.add(pokemon);
      } else {
        throw Exception("ERROR DE OBTENCION DE API");
      }
    }
    return pokemons;
  }
}
