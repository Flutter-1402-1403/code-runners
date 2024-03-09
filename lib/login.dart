// ignore_for_file: prefer_const_constructors

import 'package:app/DatabaseHandller/DtHelper.dart';
import 'package:app/common/getInfoForm.dart';
import 'package:app/main.dart';
import 'package:app/welocome.dart';
import 'package:flutter/material.dart';
import 'package:app/signUp.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formkey = GlobalKey<FormState>();
  final _conUsername = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;
  @override
  void initSate() {
    super.initState();
    dbHelper = dbHelper();
  }

  loginvalid() {
    String uname = _conUsername.text;
    String upassword = _conPassword.text;

    if (uname.isEmpty) {
    } else if (upassword.isEmpty) {
    } else {
      dbhelper dh = dbhelper();
      dh.getLoginUser(uname, upassword).then((userData) {
        if (userData != null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) => welcome()));
        }
      }).catchError((error) {
        print(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ورود',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'ورود',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/1.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'CodeRunner',
                style: TextStyle(color: Colors.black38, fontSize: 25),
              ),
              getTextFormField(
                controller: _conUsername,
                iconData: Icons.person,
                hintname: 'نام کاربری',
                inputType: TextInputType.text,
              ),
              getTextFormField(
                controller: _conPassword,
                iconData: Icons.lock,
                hintname: 'کلمه عبور',
                isObscureText: true,
              ),
              Container(
                margin: EdgeInsets.all(30),
                width: double.infinity,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      loginvalid();
                    },
                    child: Text(
                      'ورود',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('من اکانت ندارم'),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => signUp()));
                        },
                        child: Text(
                          'ثبت نام',
                          style: TextStyle(color: Colors.blue),
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => MyHomePage()));
                      },
                      child: Text('بازگشت به عنوان مهمان'),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
