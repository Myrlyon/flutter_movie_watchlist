import 'package:flutter/material.dart';
import 'package:flutter_movie_test/global_widgets/main_appbar.dart';
import 'package:flutter_movie_test/pages/HomePage/widgets/movie_gridview.dart';
import 'package:flutter_movie_test/pages/HomePage/widgets/slide_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(flexibleSpace: MainAppBar(context), elevation: 0),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: SlideImage(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(249, 241, 246, 1),
                      ),
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Now Playing at Your Nearest Cinema',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(152, 64, 97, 1))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: MovieGridView()),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
