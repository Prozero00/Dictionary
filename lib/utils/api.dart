import 'dart:convert';

import 'package:kamus/model/model_word.dart';
import 'package:http/http.dart' as http;

class API {
  static const String baseUrl =
      "https://api.dictionaryapi.dev/api/v2/entries/en/";

  static Future<ModelWord> fetchMeaning(String word) async {
    final response = await http.get(Uri.parse("$baseUrl$word"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ModelWord.fromJson(data[0]);
    } else {
      throw Exception("failed to load meaning");
    }
  }
}