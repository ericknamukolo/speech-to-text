import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class DialogBox extends StatelessWidget {
  DialogBox({this.click, this.message, this.icon, this.button, this.color});
  final Function click;
  final String message;
  final IconData icon;
  final String button;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        message,
        textAlign: TextAlign.center,
        style: kTextStytle.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 100,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: click,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  button,
                  style: kTextStytle.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
