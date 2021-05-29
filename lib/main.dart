import 'package:flutter/material.dart';
import 'package:speech_to_text_conversion/screens/welcome_screen.dart';

void main() => runApp(STTC());

class STTC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}
