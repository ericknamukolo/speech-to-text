import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text_conversion/constants.dart';

class NoTextsAvailable extends StatelessWidget {
  const NoTextsAvailable({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        SvgPicture.asset(
          'assets/box.svg',
          semanticsLabel: 'Empty',
          height: 200,
          color: Color(0xff48C9B0),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Empty',
          style: kTextStytle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'There is Nothing here',
          style: kTextStytle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
