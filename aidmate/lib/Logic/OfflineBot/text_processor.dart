import 'dart:core';

List<String> stopWords = [
  "من", "في", "إلى", "على", "عن", "مع", "لـ", "أن", "و", "ثم", "أو", "هو", "هي", "ما", "هذا", "هذه", "ذلك"
];

List<String> preprocessAr(String text) {
  // Remove any character that is not Arabic letters or space
  text = text.replaceAll(RegExp(r'[^\u0621-\u064A\s]'), '');

  // Split text into tokens
  List<String> tokens = text.split(RegExp(r'\s+'));

  // Filter out stopwords
  List<String> filteredTokens = tokens.where((word) => !stopWords.contains(word)).toList();

  return (filteredTokens.isEmpty)?tokens:filteredTokens;
}
