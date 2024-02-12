import 'package:flutter/material.dart';
import 'package:flutter_movie_test/pages/WatchlistPage/widgets/watchlist_listview.dart';

class WatchlistPage extends StatelessWidget {
  // final WatchlistPageController controller = Get.put(WatchlistPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Movie to be Watched',
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: WatchlistListview());
  }
}
