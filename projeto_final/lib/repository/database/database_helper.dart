import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_clima.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE location(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cidade TEXT,
            estado TEXT,
            latitude REAL,
            longitude REAL
          )
        ''');
      },
    );
  }
}