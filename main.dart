import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/components/my_login.dart';
import 'package:myapp/components/my_register.dart';
import 'package:myapp/dashboard.dart';
import 'package:myapp/myfavorite.dart';
import 'package:myapp/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:translator/translator.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            } else {
              bool isLoggedIn = snapshot.data ?? false;
              return isLoggedIn ? MainScreen() : MyLogin();
            }
          }
        },
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences info = await SharedPreferences.getInstance();
    return info.getString('userId') != null;
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String text = "Loading...";
  String translateText = "";
  bool isMyFavorite = false;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    validate();
    validationMyFavorite();
  }

  Future<void> validate() async {
    SharedPreferences vld = await SharedPreferences.getInstance();
    String? saveDates = vld.getString('saveDates');
    String? savefarsi = vld.getString('saveTranslate');
    String? saveMessage = vld.getString('saveMessage');
    String today = DateTime.now().toString().split(' ')[0];
    if (saveDates == today && saveMessage != null) {
      setState(() {
        text = saveMessage;
        translateText = savefarsi!;
      });
    } else {
      showMessage();
    }
  }

  Future<void> showMessage() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.quotable.io/random'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final quote = data['content'];
        final translator = GoogleTranslator();
        final translation = await translator.translate(quote, to: 'fa');

        SharedPreferences vld = await SharedPreferences.getInstance();
        String today = DateTime.now().toString().split(' ')[0];
        vld.setString('saveDates', today);
        vld.setString('saveMessage', quote);
        vld.setString('saveTranslate', translation.text);

        setState(() {
          translateText = translation.text;
          text = data['content'] + '\n';
        });
      } else {
        setState(() {
          text = 'Failed to load quote';
          translateText = "خطا در بارگزاری متن";
        });
      }
    } catch (error) {
      setState(() {
        text = 'Error: $error';
        translateText = 'خطا $error';
      });
    }
  }

  Future<void> saveFavorite(String text) async {
    SharedPreferences fvt = await SharedPreferences.getInstance();
    fvt.setString('myFavorite', text);
    fvt.setString('myFavoriteT', translateText);
    if (fvt.getString('userId') != null) {
      String? userId = fvt.getString('userId');
      final response = await http.post(
        Uri.parse('http://bluequote.freehost.io/addFavorite.php'),
        body: {
          'userId': userId.toString(),
          'quoteMain': text,
          'quoteTranslate': translateText,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          fvt.setString('id', data['Id'].toString());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${data['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('لطفا ورود یا ثبت نام کنید')));
    }
  }

  Future<void> deleteFavorite() async {
    SharedPreferences fvt = await SharedPreferences.getInstance();
    String? id = fvt.getString('id');
    fvt.remove('myFavorite');
    fvt.remove('myFavoriteT');
    final response = await http.post(
      Uri.parse('http://bluequote.freehost.io/removeFavorite.php'),
      body: {'quoteId': id.toString()},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "success") {
        fvt.remove('id');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${data['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error: ${response.statusCode}')),
      );
    }
  }

  Future<void> validationMyFavorite() async {
    SharedPreferences vld = await SharedPreferences.getInstance();
    setState(() {
      isMyFavorite = vld.getString('myFavorite') != null;
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      _navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
  }

  void _onPressed() async {
    if (isMyFavorite) {
      await deleteFavorite();
    } else {
      await saveFavorite(text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => listfavorite()));
    }
    setState(() {
      isMyFavorite = !isMyFavorite;
    });
  }

  void _onShare() {
    Share.share(text);
  }

  void _onMove() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 10, top: 20),
                width: 335,
                child: Column(
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      translateText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.blue,
                    style: BorderStyle.solid,
                    width: 2.5,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0),
              height: 2,
              width: 420,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        padding: EdgeInsets.all(10),
        activeColor: Colors.blue[900],
        gap: 10,
        color: Colors.blue[400],
        tabs: [
          GButton(
            icon: Icons.share,
            iconSize: 40,
            onPressed: _onShare,
          ),
          GButton(
            icon: isMyFavorite ? Icons.favorite : Icons.heart_broken,
            iconSize: 40,
            onPressed: _onPressed,
          ),
          GButton(
            icon: Icons.person_rounded,
            iconSize: 40,
            onPressed: _onMove,
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: _onTabSelected,
      ),
    );
  }
}
