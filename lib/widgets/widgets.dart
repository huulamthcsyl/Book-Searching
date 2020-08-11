import 'package:flutter/material.dart';

Widget appBar(String title){
  return AppBar(
    title: Text(title),
    brightness: Brightness.light,
    centerTitle: true,
    elevation: 0.0,
  );
}