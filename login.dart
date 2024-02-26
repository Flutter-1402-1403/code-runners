import 'package:app/color.dart';
import 'package:flutter/material.dart';
import 'package:app/sign-up.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void validation() {
    final FormState? _form = _formkey.currentState;
    if (_form!.validate()) {
      print('yes');
    } else {
      print('no');
    }
  }

  late bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: mco,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25),
                    ),
                  ),
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'ورود کاربر',
                    style: TextStyle(color: Colors.white, fontSize: 45),
                  ),
                  margin: EdgeInsets.only(bottom: 25),
                ),
                Form(
                    key: _formkey,
                    child: Container(
                      width: double.infinity,
                      height: 350,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return "لطفا نام کاربری را وارد کنید";
                                } else if (value!.length < 6) {
                                  return "طول نام کاربری باید حداقل 6 کاراکتر باشد";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'نام کاربری',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return "لطفا کلمه عبور خود را وارد کنید";
                                } else if (value!.length < 8) {
                                  return "طول کلمه عبور باید حداقل 8 کاراکتر باشد";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: obscureText,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: Icon(obscureText == false
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  labelText: 'رمز عبور',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  validation();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mco),
                                child: Text(
                                  'ورود',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  ' اکانت ندارم!',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (ctx) => (sign_up()),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'ثبت نام ',
                                    style: TextStyle(
                                        color: mco,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ]),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
