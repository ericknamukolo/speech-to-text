import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:speech_to_text_conversion/models/text.dart';
import 'package:http/http.dart' as http;

class TextData with ChangeNotifier {
  List<Text> textItems = [
    // Text(
    //   id: 't1',
    //   dateTime: DateTime.now(),
    //   text: 'This is an exmple text',
    // ),
    // Text(
    //   id: 't2',
    //   dateTime: DateTime.now(),
    //   text: 'This is an exmple text',
    // ),
    // Text(
    //   id: 't3',
    //   dateTime: DateTime.now(),
    //   text: 'This is an exmple text',
    // ),
    // Text(
    //   id: 't4',
    //   dateTime: DateTime.now(),
    //   text: 'This is an exmple text',
    // ),
  ];
  Future<void> fetchAndSetTexts() async {
    final url =
        'https://speech-to-text-4a4ee-default-rtdb.firebaseio.com/texts.json';
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
    final List<Text> loadedTexts = [];
    extractedData.forEach((id, text) {
      loadedTexts.add(
        Text(
          id: id,
          dateTime: DateTime.parse(text['dateTime']),
          text: text['text'],
        ),
      );
    });
    textItems = loadedTexts;
    notifyListeners();
  }

  Future<void> deleteItem(String id) async {
    final url =
        'https://speech-to-text-4a4ee-default-rtdb.firebaseio.com/texts/$id.json';
    await http.delete(Uri.parse(url));
    textItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> addItem(String text) async {
    try {
      final url =
          'https://speech-to-text-4a4ee-default-rtdb.firebaseio.com/texts.json';
      await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'text': text,
            'id': DateTime.now().toIso8601String(),
            'dateTime': DateTime.now().toIso8601String(),
          },
        ),
      );
    } catch (err) {
      print(err);
    }
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
