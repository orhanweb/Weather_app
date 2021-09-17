import 'package:flutter/material.dart';
import 'package:hava_durumu_app/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deneme',
      theme: ThemeData.dark(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
