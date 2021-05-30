import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class DialogBox extends StatelessWidget {
  DialogBox({this.click});
  final Function click;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Account Created successfully',
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
              FontAwesomeIcons.thumbsUp,
              color: Color(0xff48C9B0),
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
                  'Proceed to login',
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
