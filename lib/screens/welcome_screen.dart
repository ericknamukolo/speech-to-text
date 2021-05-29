import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speech_to_text_conversion/constants.dart';
import 'package:speech_to_text_conversion/screens/login_screen.dart';
import 'package:speech_to_text_conversion/widgets/main_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'icon',
              child: Icon(
                FontAwesomeIcons.microphone,
                size: 100.0,
                color: Color(0xff48C9B0),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Speech-To-Text',
                style: kTextStytle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'speech to text software ‘listens’ to audio and delivers an editable transcript or words',
                textAlign: TextAlign.center,
                style: kTextStytle.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            MainButton(
              click: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              text: 'Try it out',
            ),
          ],
        ),
      ),
    );
  }
}
