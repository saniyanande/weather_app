import 'package:flutter/material.dart';
import 'package:weather_app/features/Home/ui/home.dart';

Future<void> main() async{

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    routes: {
      'home':(context) => const Home(),
    },
  ));
  
}
