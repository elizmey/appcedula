class Persona {
  int? id;
  String nombre;
  String apellido;
  String cedula;
  int edad;
  String ciudad;

  Persona({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.edad,
    required this.ciudad,
  });

  // Convertir objeto a Map para guardar en SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'cedula': cedula,
      'edad': edad,
      'ciudad': ciudad,
    };
  }

  // Convertir Map a objeto Persona
  factory Persona.fromMap(Map<String, dynamic> map) {
    return Persona(
      id: map['id'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      cedula: map['cedula'],
      edad: map['edad'],
      ciudad: map['ciudad'],
    );
  }
}