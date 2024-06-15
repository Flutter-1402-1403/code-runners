import 'package:flutter/material.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/components/my_register.dart';
import 'package:myapp/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/main.dart';
import 'package:myapp/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool isvalid = true;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<void> loginUser() async {
    if (usernamecontroller.text.length < 3 ||
        passwordcontroller.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('لطفا نام کاربری یا رمز عبور را درست وارد کنید')));
      setState(() {
        isvalid = false;
      });
    } else {
      setState(() {
        isvalid = true;
      });
    }
    if (isvalid) {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse('http://bluequote.freehost.io/login.php'),
        body: {
          'username': usernamecontroller.text,
          'password': passwordcontroller.text,
        },
      );
      setState(() {
        isLoading = true;
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        SharedPreferences info = await SharedPreferences.getInstance();
        if (data['status'] == 'success') {
          info.setString('userId', data['userId'].toString());
          info.setString('username', usernamecontroller.text);
          info.setString('password', passwordcontroller.text);
          info.setString('email', data['email']);
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Main()),
          );
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(' ${data['message']}')),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ورود"),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
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
                          color: Colors.blue[200]),
                    ),
                  ),
                  SizedBox(
                    width: 420,
                    height: 50,
                    child: MyTextField(
                        controller: usernamecontroller,
                        hintText: 'ali',
                        obscureText: false),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50, bottom: 8, top: 8),
                    child: Text(
                      'رمزعبور',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.blue[200]),
                    ),
                  ),
                  SizedBox(
                    width: 420,
                    height: 50,
                    child: MyTextField(
                        controller: passwordcontroller,
                        hintText: '123@sd',
                        obscureText: false),
                  ),
                  SizedBox(height: 20),
                  MyButton(onTap: loginUser, text: 'ورود'),
                  SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => SignUpText()));
                      },
                      child: Text('اکانت ندارم'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
