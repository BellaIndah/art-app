import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static const String dbName = 'art.db';

  static Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, dbName);

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE art(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            image TEXT,
            description TEXT,
            rate REAL,
            page INTEGER,
            categoryArt TEXT,
            language TEXT
          )
          '''
        );
      },
    );
  }

  static Future<int> insertArt(Map<String, dynamic> art) async {
    final db = await database;
    return db!.insert('art', art);
  }

  static Future<Map<String, dynamic>?> getArt(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(
      'art',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>> getArts() async {
    final db = await database;
    return db!.query('art');
  }
}
