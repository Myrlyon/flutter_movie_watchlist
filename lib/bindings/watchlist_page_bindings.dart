import 'package:flutter_movie_test/controllers/watchlist_page_controller.dart';
import 'package:get/get.dart';

class WatchlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchlistPageController>(
      () => WatchlistPageController(),
    );
  }
}
