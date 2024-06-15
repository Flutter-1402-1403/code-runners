import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() {}

class listfavorite extends StatefulWidget {
  @override
  State<listfavorite> createState() => _listfavoriteState();
}

class _listfavoriteState extends State<listfavorite> {
  List<String> favorites = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchList();
  }

  Future<void> fetchList() async {
    SharedPreferences info = await SharedPreferences.getInstance();
    String? id = info.getString('userId');
    if (id != null) {
      final response = await http.post(
          Uri.parse('http://bluequote.freehost.io/showMyfavorite.php'),
          body: {'userId': info.getString('userId')});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            favorites = List<String>.from(data['quote']);
            isLoading = false;
          });
        } else {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('عملیات فراخوانی موفقیت آمیز نبود')));
            isLoading = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = "لیست مورد علاقه ها";
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => Main()));
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                height: 150,
                margin: EdgeInsets.only(right: 0, bottom: 8, top: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Colors.blue, style: BorderStyle.solid, width: 2.5),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left,
                        size: 24,
                        color: Colors.blue,
                      ),
                      Text(
                        '${favorites}',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Colors.blue[200]),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
