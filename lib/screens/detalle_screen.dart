import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/persona.dart';

class DetalleScreen extends StatelessWidget {

  final Persona persona;

  DetalleScreen({required this.persona});

  void eliminar(BuildContext context) async {

    await DatabaseHelper.instance.deletePersona(persona.id!);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Detalle Persona")),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("Nombre: ${persona.nombre} ${persona.apellido}", style: TextStyle(fontSize: 18)),

            Text("Cédula: ${persona.cedula}", style: TextStyle(fontSize: 18)),

            Text("Edad: ${persona.edad}", style: TextStyle(fontSize: 18)),

            Text("Ciudad: ${persona.ciudad}", style: TextStyle(fontSize: 18)),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => eliminar(context),
              child: Text("Eliminar Registro"),
            )
          ],
        ),
      ),
    );
  }
}