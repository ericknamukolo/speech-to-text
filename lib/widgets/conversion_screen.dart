import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

import '../constants.dart';

class ConversionScreen extends StatelessWidget {
  const ConversionScreen({
    Key key,
    @required String text,
    @required Map<String, HighlightedWord> highlights,
  })  : _text = text,
        _highlights = highlights,
        super(key: key);

  final String _text;
  final Map<String, HighlightedWord> _highlights;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 150.0),
        child: TextHighlight(
          textAlign: TextAlign.center,
          text: _text,
          words: _highlights,
          textStyle: kTextStytle,
        ),
      ),
    );
  }
}
