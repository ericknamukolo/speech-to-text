import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text_conversion/constants.dart';
import 'package:speech_to_text_conversion/models/text_data.dart';
import 'package:speech_to_text_conversion/widgets/conversion_screen.dart';
import 'package:connection_verify/connection_verify.dart';
import 'package:speech_to_text_conversion/widgets/dialog_box.dart';
import 'package:speech_to_text_conversion/widgets/saved_texts_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the Button and Start Speaking';
  final _auth = FirebaseAuth.instance;
  String displayUsername;
  FirebaseUser loggedInUser;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
      final firstLetter =
          loggedInUser.email.split('@')[0].substring(0, 1).toUpperCase();
      final rest = loggedInUser.email.split('@')[0].substring(1).toLowerCase();
      final displayName = firstLetter + rest;
      displayUsername = displayName;
    } catch (e) {
      print(e);
    }
  }

  final Map<String, HighlightedWord> _highlights = {
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'speech': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'text': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    getCurrentUser();
  }

  void logOut() {
    setState(() {
      _auth.signOut();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    void _listen() async {
      if (!_isListening) {
        bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          setState(() {
            _isListening = true;
          });
          _speech.listen(
            onResult: (val) => setState(() {
              _text = val.recognizedWords;
              if (val.hasConfidenceRating && val.confidence > 0) {}
            }),
          );
        }
      } else {
        setState(() {
          _isListening = false;
          _speech.stop();
          print(_text);
          Provider.of<TextData>(context, listen: false).addItem(_text);
        });
      }
    }

    void showADialog() {
      showDialog(
        context: context,
        builder: (context) => DialogBox(
          message: 'Check your internet connection',
          button: 'Retry',
          icon: FontAwesomeIcons.times,
          click: () {
            logOut();
          },
          color: Colors.redAccent,
        ),
      );
    }

    final tabs = [
      ConversionScreen(text: _text, highlights: _highlights),
      SavedTextsScreen(),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text('Welcome $displayUsername', style: kTextStytle),
            ),
            SizedBox(
              height: 100,
            ),
            Icon(
              Icons.settings,
              size: 90,
              color: Colors.grey,
            ),
            Center(
              child: Text(
                'Settings',
                style: kTextStytle,
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      floatingActionButton: currentIndex == 0
          ? AvatarGlow(
              endRadius: 100.0,
              animate: _isListening,
              glowColor: Color(0xff48C9B0),
              repeat: true,
              duration: Duration(milliseconds: 3000),
              repeatPauseDuration: Duration(milliseconds: 80),
              child: Container(
                height: 80,
                width: 80,
                child: FloatingActionButton(
                  onPressed: _listen,
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    size: 40,
                  ),
                  backgroundColor: Color(0xff48C9B0),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff48C9B0),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Speech To Text',
              style: kTextStytle.copyWith(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              if (await ConnectionVerify.connectionStatus()) {
                try {
                  logOut();
                } catch (e) {
                  print(e);
                }
              } else {
                showADialog();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedLabelStyle: kTextStytle.copyWith(fontSize: 14),
        selectedItemColor: Color(0xff2980B9),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.save,
              size: 30,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 30,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
