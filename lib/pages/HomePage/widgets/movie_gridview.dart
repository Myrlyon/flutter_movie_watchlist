import 'package:flutter/material.dart';
import 'package:flutter_movie_test/api/constants.dart';
import 'package:flutter_movie_test/controllers/home_page._controller.dart';
import 'package:flutter_movie_test/controllers/watchlist_page_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../database/movies_database.dart';
import '../../../models/watchlist_model.dart';

class MovieGridView extends GetView<HomePageController> {
  final controllerFavorite = Get.put(WatchlistPageController());
  final homePageController = Get.put(HomePageController());
  final MoviesDatabase _moviesDatabase = MoviesDatabase();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: 420,
          ),
          itemCount: controller.allMovies.length,
          itemBuilder: (context, index) {
            var movies = controller.allMovies[index];
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 3,
                    offset: Offset(1, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        '${Constants.IMAGE_URL}${movies.posterPath}',
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Text(
                                movies.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              constraints: BoxConstraints(
                                minHeight: 40,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize: 20,
                                  allowHalfRating: true,
                                  direction: Axis.horizontal,
                                  initialRating: movies.voteAverage / 2,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 10,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${movies.voteAverage.toStringAsFixed(2)} IMDB",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                _moviesDatabase.insertFavorite(
                                  WatchlistMovies(
                                    id: movies.id,
                                    title: movies.title,
                                    overview: movies.overview,
                                    posterPath: movies.posterPath,
                                    backdropPath: movies.backdropPath,
                                    releaseDate: movies.releaseDate.toString(),
                                    voteAverage: movies.voteAverage,
                                  ),
                                );

                                // Show Snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to Watchlist'),
                                  ),
                                );
                              },
                              child: Text("Add to Watchlist"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
