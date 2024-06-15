import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/main.dart';
import 'package:myapp/myfavorite.dart';
import 'package:myapp/profile.dart';

void dashboard() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'داشبورد کاربر',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 21,
                      color: Colors.blue[200]),
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
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => Main()));
                      }),
                ]),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.only(right: 0, bottom: 8, top: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2.5),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => profile()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left,
                            size: 24,
                            color: Colors.blue,
                          ),
                          Text(
                            'اطلاعات کاربر',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: Colors.blue[200]),
                          ),
                          Icon(
                            Icons.person_rounded,
                            size: 24,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.only(right: 0, bottom: 8, top: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2.5),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => profile()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left,
                            size: 24,
                            color: Colors.blue,
                          ),
                          Text(
                            'تغییر ایمیل',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: Colors.blue[200]),
                          ),
                          Icon(
                            Icons.email_rounded,
                            size: 24,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.only(right: 0, bottom: 8, top: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2.5),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => profile()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left,
                            size: 24,
                            color: Colors.blue,
                          ),
                          Text(
                            'تغییر رمز عبور',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: Colors.blue[200]),
                          ),
                          Icon(
                            Icons.key_rounded,
                            size: 24,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.only(right: 0, bottom: 8, top: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2.5),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => listfavorite()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left,
                            size: 24,
                            color: Colors.blue,
                          ),
                          Text(
                            'متن های مورد علاقه',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: Colors.blue[200]),
                          ),
                          Icon(
                            Icons.star_rounded,
                            size: 24,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))));
  }
}
