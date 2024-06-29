import 'package:cafecitodev/screens/add_cafecito_dev.dart';
import 'package:cafecitodev/screens/home_cafecito_dev.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyAppcafecitoDev());
}

class MyAppcafecitoDev extends StatelessWidget {
  const MyAppcafecitoDev({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      title: "Cafecito Dev",
      routes: {
        '/': (context) => MyHomeCafecito(),
        '/add-song': (context) => AddCafecitoPage(),
        '/edit-song': (context) => AddCafecitoPage(),
      },
    );
  }
}
