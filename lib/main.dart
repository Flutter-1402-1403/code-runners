import 'package:flutter/material.dart';
import 'package:app/color.dart';
import 'package:app/login.dart';
import 'package:localization/localization.dart';
import 'package:flutter/services.dart';
import 'navBar.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: mco));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mco,
        title: Text(
          'انگیزش روزانه',
          style: TextStyle(color: Colors.pink.shade400),
        ),
        centerTitle: true,
      ),
      drawer: NavBar(),
      body: const Center(
        child: Text(
          'خواستن توانستن نیست!',
          style: TextStyle(fontSize: 40.0),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: 'خانه', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'تنظیمات', icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
