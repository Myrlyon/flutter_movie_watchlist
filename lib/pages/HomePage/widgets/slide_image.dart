import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_movie_test/api/constants.dart';
import 'package:flutter_movie_test/controllers/home_page._controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SlideImage extends GetView<HomePageController> {
  SlideImage({Key? key}) : super(key: key);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getNowPlayingMovies(),
      builder: (
        context,
        snapshot,
      ) {
        var movies = controller.upComingFetch.length > 0
            ? controller.upComingFetch
            : controller.upcomingMovies;
        return Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  print(currentIndex);
                },
                child: ClipRRect(
                  child: CarouselSlider(
                    items: movies.map((movies) {
                      return Stack(
                        children: [
                          Image.network(
                            '${Constants.IMAGE_URL}${movies.backdropPath}',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '${movies.title}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      movies.releaseDate
                                          .toString()
                                          .substring(0, 4),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      movies.overview,
                                      textAlign: TextAlign.justify,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    carouselController: CarouselController(),
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 8),
                      aspectRatio: 1.78,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        currentIndex = index;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
