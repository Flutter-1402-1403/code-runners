import 'package:flutter/material.dart';

class welcome extends StatefulWidget {
  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('خوش اومدی آقا'),
      ),
      body: Column(
        children: [Text('خوش اومدی')],
      ),
    );
  }
}
