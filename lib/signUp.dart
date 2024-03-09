import 'package:app/DatabaseHandller/DtHelper.dart';
import 'package:app/Model/UserModel.dart';
import 'package:app/common/getInfoForm.dart';
import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final _formkey = GlobalKey<FormState>();
  final _conUsername = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conRePassword = TextEditingController();
  var dbHelper;
  @override
  void initSate() {
    super.initState();
    dbHelper = dbHelper();
  }

  valid() {
    final form = _formkey.currentState;
    String uname = _conUsername.text;
    String uEmail = _conEmail.text;
    String uPassword = _conPassword.text;
    String uRePassword = _conRePassword.text;

    if (_formkey.currentState!.validate()) {
      if (uPassword != uRePassword) {
      } else {
        _formkey.currentState!.save();

        UserModel umodel = UserModel(uname, uPassword);
        dbhelper dh = dbhelper();
        dh.saveData(umodel).then((userData) {
          if (userData != null) {
            print('ثبت نام شدید');
          }
        }).catchError((error) {
          print(error);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ثبت نام',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
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
                  'ثبت نام',
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
                    hintname: 'نام کاربری',
                    iconData: Icons.person,
                    inputType: TextInputType.text),
                getTextFormField(
                    controller: _conEmail,
                    hintname: 'ایمیل',
                    iconData: Icons.email,
                    inputType: TextInputType.emailAddress),
                getTextFormField(
                  controller: _conPassword,
                  hintname: 'کلمه عبور',
                  iconData: Icons.lock,
                  isObscureText: true,
                ),
                getTextFormField(
                  controller: _conRePassword,
                  hintname: 'تکرار کلمه عبور',
                  iconData: Icons.lock,
                  isObscureText: true,
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        valid();
                      },
                      child: const Text(
                        'ورود',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('من اکانت دارم'),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (ctx) => login()));
                          },
                          child: const Text(
                            'ورود',
                            style: TextStyle(color: Colors.blue, fontSize: 30),
                          )),
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
