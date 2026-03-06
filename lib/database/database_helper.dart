import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/persona.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Obtener base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('personas.db');
    return _database!;
  }

  // Crear base de datos
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Crear tabla
  Future _createDB(Database db, int version) async {

    await db.execute('''
    CREATE TABLE personas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      apellido TEXT,
      cedula TEXT,
      edad INTEGER,
      ciudad TEXT
    )
    ''');
  }

  // Insertar persona
  Future<int> insertPersona(Persona persona) async {
    final db = await instance.database;
    return await db.insert('personas', persona.toMap());
  }

  // Obtener todas las personas
  Future<List<Persona>> getPersonas() async {
    final db = await instance.database;

    final result = await db.query('personas');

    return result.map((json) => Persona.fromMap(json)).toList();
  }

  // Eliminar persona
  Future<int> deletePersona(int id) async {
    final db = await instance.database;

    return await db.delete(
      'personas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}