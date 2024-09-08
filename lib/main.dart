import 'package:flutter/material.dart';
import 'package:weather_app/features/Home/ui/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    routes: {
      'home':(context) => const Home(),
    },
  ));
  
}
