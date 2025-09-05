import 'dart:math';

List<double> transformTfidf(String sentence, List<String> vocab, List<double> idf) {
  // Tokenize (split by space, assuming text is already cleaned)
  List<String> tokens = sentence.split(' ');

  // Compute raw TF × IDF
  List<double> tfidfVals = [];
  for (int i = 0; i < vocab.length; i++) {
    String word = vocab[i];
    double idfVal = idf[i];
    int tf = tokens.where((t) => t == word).length; // Count occurrences
    tfidfVals.add(tf * idfVal);
  }

  // Apply L2 normalization
  double norm = sqrt(tfidfVals.fold(0, (sum, val) => sum + val * val));
  List<double> normalized = tfidfVals.map((val) => norm != 0.0 ? val / norm : 0.0).toList();

  return normalized;
}
