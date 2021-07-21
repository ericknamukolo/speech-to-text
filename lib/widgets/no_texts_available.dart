import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text_conversion/constants.dart';

class NoTextsAvailable extends StatelessWidget {
  final Function refresh;
  NoTextsAvailable({this.refresh});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
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
        SizedBox(
          height: 10.0,
        ),
        // ignore: deprecated_member_use
        RaisedButton.icon(
          elevation: 5.0,
          onPressed: refresh,
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          label: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Refresh',
              style: kTextStytle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
