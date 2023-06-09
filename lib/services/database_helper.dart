import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:watch_me/models/movie.dart';

class DatabaseHelper {
  static const _databaseName = "WatchMe.db";
  static const _databaseVersion = 1;

  static const table = 'movies';

  static const columnId = 'id';
  static const columnImageUrl = 'imageUrl';
  static const columnTitle = 'title';
  static const columnGenre = 'genre';
  static const columnAgeRange = 'ageRange';
  static const columnRuntime = 'runtime';
  static const columnRating = 'rating';
  static const columnDescription = 'description';
  static const columnYear = 'year';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> initializeDatabase() async {
    _database = await _initDatabase();
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnImageUrl TEXT NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnGenre TEXT NOT NULL,
            $columnAgeRange TEXT NOT NULL,
            $columnRuntime INTEGER NOT NULL,
            $columnRating REAL NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnYear INTEGER NOT NULL
          )
          ''');
  }

  static Future<List<Movie>?> getAll() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate((maps.length), (index) => Movie.fromJson(maps[index]));
  }

  static Future<int> insert(Movie movie) async {
    Database db = await instance.database;
    return await db.insert(table, movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> update(Movie movie) async {
    Database db = await instance.database;
    return await db.update(table, movie.toJson(),
        where: 'id = ?',
        whereArgs: [movie.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> delete(Movie movie) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [movie.id]);
  }
}
