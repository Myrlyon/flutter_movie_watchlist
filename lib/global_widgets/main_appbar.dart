import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget MainAppBar(context) {
  return AppBar(
    title: const CupertinoSearchTextField(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      prefixIcon: Icon(
        Icons.search,
        size: 18,
      ),
      placeholder: "Find any items",
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    actions: [
      IconButton(
        icon: const Icon(
          Icons.notifications,
          color: Colors.grey,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.wb_sunny_outlined,
          color: Colors.grey,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
