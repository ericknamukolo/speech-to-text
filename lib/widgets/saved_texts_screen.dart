import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text_conversion/models/text_data.dart';
import 'package:speech_to_text_conversion/widgets/no_texts_available.dart';
import 'package:speech_to_text_conversion/widgets/text_card.dart';

class SavedTextsScreen extends StatefulWidget {
  @override
  _SavedTextsScreenState createState() => _SavedTextsScreenState();
}

class _SavedTextsScreenState extends State<SavedTextsScreen> {
  Future<void> _refresh(BuildContext context) {
    return Provider.of<TextData>(context, listen: false).fetchAndSetTexts();
  }

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textData = Provider.of<TextData>(context);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '${textData.textItems.length}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: textData.textItems.isEmpty
              ? _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : NoTextsAvailable(
                      refresh: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await Provider.of<TextData>(context, listen: false)
                            .fetchAndSetTexts();
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () => _refresh(context),
                  child: ListView.builder(
                    itemBuilder: (context, index) => TextCard(
                      text: textData.textItems[index].text,
                      id: textData.textItems[index].id,
                      dateTime: textData.textItems[index].dateTime,
                    ),
                    itemCount: textData.textItems.length,
                  ),
                ),
        ),
      ],
    );
  }
}
