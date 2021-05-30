import 'package:flutter/material.dart';

import '../constants.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        error,
        textAlign: TextAlign.center,
        style: kTextStytle.copyWith(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
