import 'package:flutter/material.dart';

import '../constans.dart';
import '../models/message.dart';

class chatBubble extends StatelessWidget {
   chatBubble({
    super.key,
    required this.message
  });
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        child: Text(message.message!,
            style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19),
                topRight: Radius.circular(19),
                bottomRight: Radius.circular(19))),
      ),
    );
  }
}
