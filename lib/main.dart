import 'package:flutter/material.dart';
import 'package:flutter_movie_test/global_widgets/bottom_navbar.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(152, 64, 97, 1)),
        useMaterial3: true,
      ),
      home: BottomNavbar(),
    );
  }
}
