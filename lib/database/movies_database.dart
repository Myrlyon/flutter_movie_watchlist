import 'package:flutter_movie_test/models/watchlist_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabase {
  static const String databaseName = 'favorite.db';
  static const int databaseVersion = 1;

  final String favoriteTable = 'favorite_table';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnOverview = 'overview';
  final String columnPosterPath = 'posterPath';
  final String columnBackdropPath = 'backdropPath';
  final String columnReleaseDate = 'releaseDate';
  final String columnVoteAverage = 'voteAverage';

  RxList<WatchlistMovies> favoritesMovie = <WatchlistMovies>[].obs;

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    var database =
        await openDatabase(path, version: databaseVersion, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $favoriteTable (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT,
        $columnOverview TEXT,
        $columnPosterPath TEXT,
        $columnBackdropPath TEXT,
        $columnReleaseDate TEXT,
        $columnVoteAverage REAL
      )
    ''');
    newVersion = databaseVersion;
  }

  Future<List<WatchlistMovies>> getFavorites() async {
    final db = await initializeDatabase();
    List<Map<String, dynamic>> maps = await db.query(favoriteTable);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        favoritesMovie.add(WatchlistMovies.fromMap(maps[i]));
      }
    }
    return favoritesMovie;
  }

  Future<int> insertFavorite(WatchlistMovies favoriteMovie) async {
    final db = await initializeDatabase();
    int result = await db.insert(favoriteTable, favoriteMovie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    favoritesMovie.add(favoriteMovie);
    return result;
  }

  Future<int> deleteFavorite(WatchlistMovies favoriteMovie) async {
    final db = await initializeDatabase();
    int result = await db.delete(favoriteTable,
        where: '$columnId = ?', whereArgs: [favoriteMovie.id]);
    favoritesMovie.remove(favoriteMovie);
    return result;
  }
}
