import 'package:flutter/material.dart';

class getTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hintname;
  IconData? iconData;
  bool isObscureText;
  TextInputType inputType;
  getTextFormField(
      {this.controller,
      this.hintname,
      this.iconData,
      this.isObscureText = false,
      this.inputType = TextInputType.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "لطفا مقدار $hintname وارد کنید";
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(36),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(iconData),
          hintText: hintname,
          labelText: hintname,
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
