import 'package:flutter/foundation.dart';
import 'package:speech_to_text_conversion/models/text.dart';
import 'package:provider/provider.dart';

class TextData with ChangeNotifier {
  List<Text> textItems = [
    Text(
      id: 't1',
      dateTime: DateTime.now(),
      text: 'This is an exmple text',
    ),
    Text(
      id: 't2',
      dateTime: DateTime.now(),
      text: 'This is an exmple text',
    ),
    Text(
      id: 't3',
      dateTime: DateTime.now(),
      text: 'This is an exmple text',
    ),
    Text(
      id: 't4',
      dateTime: DateTime.now(),
      text: 'This is an exmple text',
    ),
    Text(
      id: 't5',
      dateTime: DateTime.now(),
      text: 'This is an exmple text boiiiiiii',
    ),
  ];

  void deleteItem(String id) {
    textItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void addItem(String text) {
    textItems.add(
      Text(
        text: text,
        id: DateTime.now().toString(),
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
