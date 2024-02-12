import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../api/constants.dart';
import '../../../controllers/watchlist_page_controller.dart';

class WatchlistListview extends StatelessWidget {
  WatchlistListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WatchlistPageController controller = Get.find();

    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchFavorites();
      },
      child: Obx(() {
        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            var favorite = controller.favorites[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: GestureDetector(
                onLongPress: () {
                  _showDeleteConfirmationDialog(context, () {
                    controller.deleteFavorite(favorite);
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        offset: Offset(1, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            '${Constants.IMAGE_URL}${favorite.posterPath}',
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favorite.title,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              favorite.releaseDate.toString().substring(0, 4),
                              textAlign: TextAlign.left,
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
                                    initialRating: favorite.voteAverage / 2,
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
                                    "${favorite.voteAverage.toStringAsFixed(2)} IMDB",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              favorite.overview,
                              textAlign: TextAlign.justify,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content:
              Text("Are you sure you want to remove this from your watchlist?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
              child: Text("Delete"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
