import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/components/my_button.dart';
import 'package:myapp/components/my_login.dart';
import 'package:myapp/components/my_textfield.dart';
import 'package:myapp/profile.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/main.dart';
import 'package:email_validator/email_validator.dart';

class SignUpText extends StatefulWidget {
  @override
  _SignUpTextState createState() => _SignUpTextState();
}

class _SignUpTextState extends State<SignUpText> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool status = true;
  bool isLoading = false;
  Future<void> registerUser() async {
    bool isvalid = EmailValidator.validate(emailController.text);
    if (!isvalid) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لطفا ایمیل خود را درست وارد کنید')));
      setState(() {
        status = false;
      });
    } else {
      setState(() {
        status = true;
      });
    }
    if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('لطفا کلمه عبور را بیشتر از 8 کاراکتر وارد کنید')));
      setState(() {
        status = false;
      });
    } else {
      setState(() {
        status = true;
      });
    }
    checkValue(usernameController.text);
    setState(() {
      isLoading = true;
    });
    if (status && passwordController.text == confirmPasswordController.text) {
      final response = await http.post(
        Uri.parse('http://bluequote.freehost.io/register.php'),
        body: {
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
      setState(() {
        isLoading = true;
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            isLoading = false;
          });
          SharedPreferences info = await SharedPreferences.getInstance();
          info.setString('userId', data["Id"].toString());
          info.setString('username', usernameController.text);
          info.setString('email', emailController.text);
          info.setString('password', passwordController.text);
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
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
    }
  }

  checkValue(String username) {
    if (username.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لطفا نام کاربری را درست وارد کنید')));
      setState(() {
        status = false;
      });
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ثبت نام"),
      ),
      body: SingleChildScrollView(
        child: isLoading
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
                            color: Colors.blue[200]),
                      ),
                    ),
                    SizedBox(
                      width: 420,
                      height: 50,
                      child: MyTextField(
                          controller: usernameController,
                          hintText: 'ali',
                          obscureText: false),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50, bottom: 8, top: 8),
                      child: Text(
                        'ایمیل',
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
                          controller: emailController,
                          hintText: 'example@gmail.com',
                          obscureText: false),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50, bottom: 8, top: 8),
                      child: Text(
                        'کلمه عبور',
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
                          controller: passwordController,
                          hintText: '123@sd',
                          obscureText: false),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50, bottom: 8, top: 8),
                      child: Text(
                        'تکرار کلمه عبور',
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
                          controller: confirmPasswordController,
                          hintText: '123@sd',
                          obscureText: false),
                    ),
                    SizedBox(height: 20),
                    MyButton(
                      onTap: registerUser,
                      text: 'ثبت نام',
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => MyLogin()));
                        },
                        child: Text('اکانت دارم'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
