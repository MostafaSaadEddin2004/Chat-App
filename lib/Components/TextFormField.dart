import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  CustomTextForm({this.lable, this.hintText, this.onTap});
  String onChange(String? data) {
    return data!;
  }

  String? lable;
  String? hintText;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        hintText: hintText,
        label: Text(
          lable!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            gapPadding: 16,
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            gapPadding: 16,
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
