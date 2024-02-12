import 'package:flutter/material.dart';
import 'package:flutter_movie_test/pages/Homepage/home_page.dart';
import 'package:flutter_movie_test/pages/WatchlistPage/watchlist_page.dart';

class BottomNavbar extends StatefulWidget {
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void navigationTapped(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // this is all pages here in list we can choose index when click bottom navigation bar
    List<Widget> _allPages = [
      HomePage(),
      WatchlistPage(),
    ];

    return Scaffold(
      body: _allPages[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  // Bottom navigation bar area you can choose icons what you want.
  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: navigationTapped,
      // iconSize: 28,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.movie_creation_rounded,
              size: 22,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_rounded,
              size: 22,
            ),
            label: 'Wishlist'),
      ],
    );
  }
}
