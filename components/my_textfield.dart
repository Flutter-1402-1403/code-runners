import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        style: TextStyle(color: Color.fromARGB(151, 0, 4, 12)),
        textAlign: TextAlign.right,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.blue, width: 2.3)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade700)),
          fillColor: const Color.fromARGB(255, 243, 244, 245),
          filled: true,
          hintText: hintText,
          hintStyle:
              TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
