import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text_conversion/constants.dart';
import 'package:speech_to_text_conversion/models/text_data.dart';

class TextCard extends StatelessWidget {
  final String text;
  final String id;
  final DateTime dateTime;
  TextCard({this.dateTime, this.id, this.text});

  Future<void> delete() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              style: kTextStytle.copyWith(
                fontSize: 13,
              ),
              overflow: TextOverflow.fade,
              // softWrap: false,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: text,
                    ),
                  );
                  print('Copied $text');
                },
                icon: Icon(
                  Icons.copy,
                  color: Color(0xff48C9B0),
                ),
              ),
              Text(
                DateFormat('yyyy-MM-dd – kk:mm').format(dateTime).toString(),
                style: kTextStytle.copyWith(
                  fontSize: 13,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<TextData>(context, listen: false).deleteItem(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Item Removed',
                        style: kTextStytle.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
