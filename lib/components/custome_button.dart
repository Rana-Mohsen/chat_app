import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomeButton extends StatelessWidget {
  CustomeButton({required this.text,required this.onTap});

  String text;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(text),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
      ),
    );
  }
}
