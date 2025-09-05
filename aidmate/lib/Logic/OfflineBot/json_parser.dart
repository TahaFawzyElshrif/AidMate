import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Map<String, String>>> loadAllQuestionsAnswers() async {
  final String response = await rootBundle.loadString('assets/data/offline_questions.json');
  final List<dynamic> data = json.decode(response);
  print(data.toString());
  return data.map((item) {
    return {
      "question": item["question"] as String,
      "answer": item["answer"] as String,
    };
  }).toList();
}


Future<Map<String, dynamic>> loadVocab_IDF() async {
    // Load JSON string from assets
    final String response = await rootBundle.loadString('assets/data/vocab_idf_questions.json');

    // Decode JSON string into a Map
    final Map<String, dynamic> data = json.decode(response);

    // Extract Vocab as List<String>
    final List<String> vocab = List<String>.from(data['Vocab']);

    // Extract IDF as List<double>
    final List<double> idf = List<double>.from(
        data['IDF'].map((x) => x.toDouble())
    );

    return {
      'Vocab': vocab,
      'IDF': idf,
    };
  }

Future<List<List<double>>> loadTfidfMatrix() async {
  String jsonString = await rootBundle.loadString('assets/data/tfidf_questions.json');
  Map<String, dynamic> jsonData = jsonDecode(jsonString);

    List<dynamic> matrixData = jsonData['TFIDF_Matrix'];

    List<List<double>> matrix = matrixData.map<List<double>>((row) {
      return row.map<double>((value) => (value as num).toDouble()).toList();
    }).toList();

    return matrix;
  }


