import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore: must_be_immutable
class CustomeTextField extends StatelessWidget {
  CustomeTextField({super.key, this.hintText, required this.onChange,required this.validator});

  String? hintText;
  Function(String) onChange;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        )),
      ),
    );
  }
}
