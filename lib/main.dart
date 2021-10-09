import 'package:flutter/material.dart';
import 'detail.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (BuildContext ctx) => const Home(),
        '/detail': (BuildContext ctx) => const Detail(),
      },
    );
  }
}
