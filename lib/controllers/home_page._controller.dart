import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_movie_test/api/constants.dart';
import 'package:flutter_movie_test/database/movies_database.dart';
import 'package:flutter_movie_test/models/movies_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isFavorite = false.obs;
  RxList allMovies = [].obs;
  RxList upcomingMovies = [].obs;
  RxList popularMovies = [].obs;
  RxList topRatedMovies = [].obs;
  RxList nowPlayingMovies = [].obs;
  RxList<MoviesModel> upComingFetch = <MoviesModel>[].obs;
  Uint8List? imageBytes;

  @override
  void onInit() {
    super.onInit();
    getAllMovies();
    getUpcomingMovies();
    getPopularMovies();
    getTopRatedMovies();
    getNowPlayingMovies();
  }

  Future getAllMovies() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('${Constants.BASE_URL}${Constants.ENDPOINT_TRENDING}'),
      );
      if (response.statusCode == 200) {
        isLoading(false);
        final content = json.decode(response.body)['results'];
        for (var item in content) {
          allMovies.add(Result.fromJson(item));
        }
      } else {
        print("Failed to load data!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future getUpcomingMovies() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('${Constants.BASE_URL}${Constants.upComingApiUrl}'),
      );
      if (response.statusCode == 200) {
        isLoading(false);
        final content = json.decode(response.body)['results'];
        for (var item in content) {
          upcomingMovies.add(Result.fromJson(item));
        }
      } else {
        print("Failed to load data!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future getPopularMovies() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('${Constants.BASE_URL}${Constants.popularApiUrl}'),
      );
      if (response.statusCode == 200) {
        isLoading(false);
        final content = json.decode(response.body)['results'];
        for (var item in content) {
          popularMovies.add(Result.fromJson(item));
        }
      } else {
        print("Failed to load data!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future getTopRatedMovies() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('${Constants.BASE_URL}${Constants.topRatedApiUrl}'),
      );
      if (response.statusCode == 200) {
        isLoading(false);
        final content = json.decode(response.body)['results'];
        for (var item in content) {
          topRatedMovies.add(Result.fromJson(item));
        }
      } else {
        print("Failed to load data!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future getNowPlayingMovies() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('${Constants.BASE_URL}${Constants.nowPlayingApiUrl}'),
      );
      if (response.statusCode == 200) {
        isLoading(false);
        final content = json.decode(response.body)['results'];
        for (var item in content) {
          nowPlayingMovies.add(Result.fromJson(item));
        }
      } else {
        print("Failed to load data!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchNowPlayingMovies() async {
    // ignore: unused_local_variable
    var db = MoviesDatabase();
    var favoriteList = await getUpcomingMovies();
    upComingFetch.assignAll(favoriteList);
  }
}
