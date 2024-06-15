import 'package:flutter/material.dart';
import 'package:myapp/components/my_login.dart';
import 'package:myapp/components/my_register.dart';
import 'package:myapp/dashboard.dart';
import 'package:myapp/main.dart';
import 'package:myapp/myfavorite.dart';
import 'components/my_textfield.dart';
import 'components/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(profile());
}

class profile extends StatelessWidget {
  profile({super.key});
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    validationInformation();
  }

  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  String? username = 'unknown';
  String? email = 'unknown';
  String? password = 'unknown';
  String? threeTitr;

  bool isvalid = true;
  bool isLoading = false;
  Future<void> validationInformation() async {
    SharedPreferences info = await SharedPreferences.getInstance();
    setState(() {
      username = info.getString('username') ?? 'unknown';
      email = info.getString('email') ?? 'unknown';
      password = info.getString('password') ?? 'unknown';
      usernamecontroller.text = username!;
      emailcontroller.text = email!;
      passwordcontroller.text = password!;
      if (info.getString('username') != null) {
        threeTitr = 'خروج';
      } else {
        threeTitr = '';
      }
    });
  }

  Future<void> updateUser() async {
    SharedPreferences info = await SharedPreferences.getInstance();
    String? userId = info.getString('userId');
    var validEmail = EmailValidator.validate(emailcontroller.text);
    if (usernamecontroller.text.length < 3 &&
        passwordcontroller.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'لطفا نام کاربری کمتر از 3 کاراکتر و رمز عبور کمتر از 8 کاراکتر نباشد')));
      setState(() {
        isvalid = false;
      });
    } else {
      setState(() {
        isvalid = true;
      });
    }
    if (!validEmail) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لطفا ایمیل را درست وارد کنید')));
      setState(() {
        isvalid = false;
      });
    } else {
      setState(() {
        isvalid = true;
      });
    }
    setState(() {
      isLoading = true;
    });

    if (isvalid && userId != null) {
      SharedPreferences info = await SharedPreferences.getInstance();
      final response = await http.post(
          Uri.parse('http://bluequote.freehost.io/updateUser.php'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'userId': info.getString('userId'),
            'username': usernamecontroller.text,
            'email': emailcontroller.text,
            'password': passwordcontroller.text
          });
      setState(() {
        isLoading = true;
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            isLoading = false;
          });
          info.setString('username', data['username']);
          info.setString('email', data['email']);
          info.setString('password', data['password']);
          validationInformation();
        }
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('ارتباط با سرور برقرار نشد')));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لطفا ابتدا ثبت نام یا ورود کنید')));
    }
  }

  Future<void> logout() async {
    final response =
        await http.get(Uri.parse('http://bluequote.freehost.io/logout.php'));
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      SharedPreferences info = await SharedPreferences.getInstance();
      info.remove('userId');
      info.remove('username');
      info.remove('email');
      info.remove('password');
      usernamecontroller.text = info.getString('username') ?? '';
      emailcontroller.text = info.getString('email') ?? '';
      passwordcontroller.text = info.getString('password') ?? '';
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => MyLogin()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'پروفایل کاربر',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 21,
            color: Colors.blue[200],
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_right_alt,
              size: 40,
              color: Colors.blue[200],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => MyApp()),
              );
            },
          )
        ],
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 50, bottom: 8, top: 8),
                    child: Text(
                      'نام کاربری',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Colors.blue[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 420,
                    height: 50,
                    child: MyTextField(
                      controller: usernamecontroller,
                      hintText: username!,
                      obscureText: false,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50, bottom: 8, top: 8),
                    child: Text(
                      'ایمیل',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Colors.blue[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 420,
                    height: 50,
                    child: MyTextField(
                      controller: emailcontroller,
                      hintText: email!,
                      obscureText: false,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50, bottom: 8, top: 8),
                    child: Text(
                      'کلمه عبور',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Colors.blue[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 420,
                    height: 50,
                    child: MyTextField(
                      controller: passwordcontroller,
                      hintText: password!,
                      obscureText: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    height: 10,
                  ),
                  SizedBox(
                    child: MyButton(
                      onTap: updateUser,
                      text: 'بروزرسانی',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: TextButton(
                          onPressed: logout, child: Text(threeTitr!)))
                ],
              ),
            ),
    );
  }
}
