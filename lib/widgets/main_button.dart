import 'package:flutter/material.dart';

import '../constants.dart';

class MainButton extends StatelessWidget {
  MainButton({this.click, this.text});
  final Function click;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        margin: EdgeInsets.only(top: 30),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff2980B9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3.0, 1.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: kTextStytle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
