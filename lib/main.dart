import 'package:flutter/material.dart';
// import 'pages/Localisation_page.dart';
import 'pages/Localisation_page.dart';
import 'pages/LoginPage.dart';
// import 'pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Localisation_page(),
    );
  }
}
