import 'package:flutter/material.dart';
import 'package:proyecto_final/API/API.dart';
import 'package:proyecto_final/controladorFavoritos.dart';
import 'package:proyecto_final/models/Pokemon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'vistas.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int index = 0;

  late Future<List<Pokemon>> pokemons;

  @override
  void initState() {
    super.initState();
    pokemons = API().getAPI(40);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: const Text("POKEDEX"), backgroundColor: Colors.red),
            body: FutureBuilder(
                future: pokemons,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      child: Vistas(snapshot.data!).getView(index),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.hasError}"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.catching_pokemon_outlined),
                    label: "Lista de pokemons"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favoritos"),
              ],
              fixedColor: Colors.red,
              currentIndex: index,
              onTap: setIndex,
            )),
      ),
    );
  }

  void setIndex(int index) {
    setState(() {
      this.index = index;
      ControladorFavoritos().actualizarFavoritos();
    });
  }
}
