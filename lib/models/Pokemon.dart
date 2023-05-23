// ignore_for_file: file_names

class Pokemon {
  String nombre;
  List<String> habilidades;
  int altura;
  bool favorito = false;
  String imagen;
  List<String> tipos;
  List<Estadistica> estadisticas;
  int peso;

  Pokemon(this.nombre, this.habilidades, this.altura, this.imagen, this.tipos,
      this.estadisticas, this.peso);

  void changeFavorito() {
    favorito = !favorito;
  }

  Pokemon.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        habilidades = List<String>.from(map['habilidades']),
        altura = map['altura'],
        favorito = map['favorito'],
        imagen = map['imagen'],
        tipos = List<String>.from(map['tipos']),
        estadisticas = List<Estadistica>.from(
            map['estadisticas'].map((model) => Estadistica.fromMap(model))),
        peso = map['peso'];

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> stats = [];

    for (Estadistica stat in estadisticas) {
      Map<String, dynamic> estado = stat.toMap();
      stats.add(estado);
    }

    return {
      'nombre': nombre,
      'habilidades': habilidades,
      'altura': altura,
      'favorito': favorito,
      'imagen': imagen,
      'tipos': tipos,
      'estadisticas': stats,
      'peso': peso,
    };
  }
}

class Estadistica {
  late String nombre;
  late int valorBase;

  Estadistica(this.nombre, this.valorBase);

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'valorBase': valorBase,
    };
  }

  Estadistica.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        valorBase = map['valorBase'];
}
