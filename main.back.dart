import 'package:app/core.dart';
import 'package:flutter/material.dart';
import 'package:app/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'info_screen.dart';
import 'lib.dart';
import 'package:meta/meta.dart';
import 'firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

main() async* {
  void main() {
    // karbadio();
    karbahttp();
  }

  // Initialize hive
  await Hive.initFlutter();
  // Open the peopleBox
  await Hive.openBox('peopleBox');
  runApp(MyApp() as Widget);
}

void karbahttp() {
  karbahttp();
}

/*void httpclinet() async {
  var requests;
  var url = Uri.parse(
      "import requests
api_url = "https://hafezapi.emrani.net/api/Fal?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1leXNhbWFza2FyaWFuMjRAZ21haWwuY29tIiwibmJmIjoxNzA5Mzk1NDM1LCJleHAiOjI1MzQwMjMwMDgwMCwiaWF0IjoxNzA5Mzk1NDM1LCJpc3MiOiJodHRwOi8vaGFmZXphcGkuZW1yYW5pLm5ldCIsImF1ZCI6Im1leXNhbWFza2FyaWFuMjRAZ21haWwuY29tIn0.eaCAdXYznKRfbXARQ1-mzODfnzQYxP1QL9J783GSXMc"
  response = requests.get(url)
  print(response.json())");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    print("con");
  } else {
    print("notcon");
  }
}

void karbadio() async {
  var clinet = Dio();
  var response1 = await clinet.get("");
  print(response1);
}
*/
class Hive {
  static openBox(String s) {}

  static initFlutter() {}
}

class MyApp extends StatelessWidget {
  @override
  // ignore: override_on_non_overriding_member
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      navigatorKey: Get.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const InfoScreen(),
    );
  }
}

mixin purple {}

class StatelessWidget {}

class Colors {
  // ignore: prefer_typing_uninitialized_variables
  static var purple;
}
