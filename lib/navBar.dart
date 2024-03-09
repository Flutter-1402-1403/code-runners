import 'dart:io';
import 'package:app/login.dart';
import 'package:app/main.dart';
import 'package:app/signUp.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('نام کاربری'),
            accountEmail: const Text('ایمیل شما'),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: const Text('صفحه اصلی'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => (MyApp())));
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: const Text('ورود'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => (login())));
            },
          ),
          ListTile(
            leading: Icon(Icons.outbond),
            title: const Text('ثبت نام'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => (signUp())));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('خروج'),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
