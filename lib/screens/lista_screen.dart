import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/persona.dart';
import 'registro_screen.dart';
import 'detalle_screen.dart';

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {

  List<Persona> personas = [];

  void cargarPersonas() async {
  final datos = await DatabaseHelper.instance.getPersonas();

  setState(() {
    personas = datos;
  });
}

  @override
  void initState() {
    super.initState();
    cargarPersonas();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Lista de Personas")),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {

  final resultado = await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => RegistroScreen()),
  );

  if (resultado == true) {
    cargarPersonas();
  }
},
      ),

      body: ListView.builder(
        itemCount: personas.length,

        itemBuilder: (context, index) {

          final persona = personas[index];

          return ListTile(
            title: Text("${persona.nombre} ${persona.apellido}"),
            subtitle: Text("Cédula: ${persona.cedula}"),

            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetalleScreen(persona: persona),
                ),
              );

              cargarPersonas();
            },
          );
        },
      ),
    );
  }
}