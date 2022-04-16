import '../game/game_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tableProfile = 'profile';
const String columnId = 'id';
const String columnName = 'name';
const String columnPlatform = 'platform';

class DatabaseProvider {
  Database? _database;

  Future<Database> _initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'game.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE profile(id TEXT PRIMARY KEY, name TEXT NULL, platform TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDB();
    return _database!;
  }

  Future<void> insertProfile(Profile profile) async {
    final Database db = await database;
    await db.insert(
      tableProfile,
      profile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateName(String name) async {
    final Database db = await database;
    await db.rawUpdate('UPDATE Profile SET name = ?', [name]);
  }

  Future<Profile?> getProfile() async {
    final Database db = await database;
    final List<Map<String, Object?>> response = await db.query(tableProfile);
    return response.isNotEmpty ? Profile.fromMap(response.first) : null;
  }
}