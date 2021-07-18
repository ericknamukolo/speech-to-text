import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text_conversion/models/text_data.dart';
import 'package:speech_to_text_conversion/screens/welcome_screen.dart';

void main() => runApp(STTC());

class STTC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TextData(),
        ),
      ],
      child: MaterialApp(
        home: WelcomeScreen(),
      ),
    );
  }
}
