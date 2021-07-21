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
  //Render background for the dismissible widget
  Container renderBackground(
      BuildContext context, Color color, Alignment alignment, IconData icon) {
    return Container(
      alignment: alignment,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Icon(
        icon,
        color: Colors.white,
        size: 70.0,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  //Delete and show snackbar
  void _deleteAndShowSnackbar(BuildContext context) {
    Provider.of<TextData>(context, listen: false).deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 20),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Deleting Text...',
              style: kTextStytle.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Color(0xff48C9B0),
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  //Copy text and show snackbar
  void _copyTextAndShowSnackbar(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 20),
        content: Text(
          'Text Copied to ClipBoard',
          style: kTextStytle.copyWith(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      //direction: DismissDirection.horizontal,
      secondaryBackground: renderBackground(context,
          Theme.of(context).errorColor, Alignment.centerRight, Icons.delete),
      background: renderBackground(
          context, Color(0xff48C9B0), Alignment.centerLeft, Icons.copy),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          //delete
          _deleteAndShowSnackbar(context);
        }
      },

      child: Container(
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
                  onPressed: () => _copyTextAndShowSnackbar(context),
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
                  onPressed: () => _deleteAndShowSnackbar(context),
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
