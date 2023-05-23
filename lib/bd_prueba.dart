import 'package:proyecto_final/models/Pokemon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Prueba {
  //static List<Pokemon> favoritos = [];
/*
  void removePokemon(Pokemon pok) {
    favoritos.removeWhere((element) => element.nombre == pok.nombre);
  }

  void printFavoritos() {
    for (Pokemon item in favoritos) {
      print(item.nombre);
    }
  }*/

  Future<void> addPokemon(Pokemon pokemon) async {
    //favoritos.add(pokemon);
    await FirebaseFirestore.instance
        .collection('pokemons')
        .add(pokemon.toMap());
  }

  Future<Pokemon> getPokemon(String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('pokemons').doc(id).get();
    return Pokemon.fromMap(snapshot.data()! as Map<String, dynamic>);
  }

  Future<List<Pokemon>> getPokemons() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('pokemons').get();
    return snapshot.docs
        .map((doc) => Pokemon.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<Pokemon>> getPokemonsStream() {
    return FirebaseFirestore.instance.collection('pokemons').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Pokemon.fromMap(doc.data())).toList());
  }

  Future<void> removePokemon(String nombre) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('pokemons')
        .where("nombre", isEqualTo: nombre)
        .get();
    for (DocumentSnapshot doc in snapshot.docs) {
      await FirebaseFirestore.instance
          .collection("pokemons")
          .doc(doc.id)
          .delete();
    }
  }
}
