import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/persona.dart';

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {

  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final cedulaController = TextEditingController();
  final edadController = TextEditingController();
  final ciudadController = TextEditingController();

  // Validar cédula (10 dígitos)
  bool validarCedula(String cedula) {
    return cedula.length == 10;
  }

  void guardarPersona() async {

    if (!validarCedula(cedulaController.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Cédula inválida")));
      return;
    }

    final persona = Persona(
      nombre: nombreController.text,
      apellido: apellidoController.text,
      cedula: cedulaController.text,
      edad: int.parse(edadController.text),
      ciudad: ciudadController.text,
    );

    await DatabaseHelper.instance.insertPersona(persona);

// Mostrar mensaje de éxito
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text("Te registraste con éxito"),
    duration: Duration(seconds: 2),
  ),
);

// Regresar a la lista después de 2 segundos
Future.delayed(Duration(seconds: 2), () {
  Navigator.pop(context, true);
});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Registro Persona")),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(controller: nombreController, decoration: InputDecoration(labelText: "Nombre")),

            TextField(controller: apellidoController, decoration: InputDecoration(labelText: "Apellido")),

            TextField(controller: cedulaController, decoration: InputDecoration(labelText: "Cédula")),

            TextField(controller: edadController, decoration: InputDecoration(labelText: "Edad")),

            TextField(controller: ciudadController, decoration: InputDecoration(labelText: "Ciudad")),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: guardarPersona,
              child: Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }
}