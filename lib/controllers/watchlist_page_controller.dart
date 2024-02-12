import 'package:flutter_movie_test/database/movies_database.dart';
import 'package:flutter_movie_test/models/watchlist_model.dart';
import 'package:get/get.dart';

class WatchlistPageController extends GetxController {
  RxList<WatchlistMovies> favorites = <WatchlistMovies>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    var db = MoviesDatabase();
    var favoriteList = await db.getFavorites();
    favorites.assignAll(favoriteList);
  }

  Future<void> deleteFavorite(WatchlistMovies favoriteMovie) async {
    var db = MoviesDatabase();
    await db.deleteFavorite(favoriteMovie);
    favorites.remove(favoriteMovie);
  }
}
