import 'dart:math';

List<double> cosineSimilarityOneToMany(List<double> vec, List<List<double>> matrix) {
  List<double> results = [];

  // Compute norm of the input vector
  double normVec = sqrt(vec.fold(0.0, (sum, a) => sum + a * a));

  for (var row in matrix) {
    // Compute dot product
    double dotProduct = 0.0;
    for (int i = 0; i < vec.length; i++) {
      dotProduct += vec[i] * row[i];
    }

    // Compute norm of the row
    double normRow = sqrt(row.fold(0.0, (sum, b) => sum + b * b));

    // Compute cosine similarity
    double similarity = (normVec != 0.0 && normRow != 0.0)
        ? dotProduct / (normVec * normRow)
        : 0.0;

    results.add(similarity);
  }

  return results;
}

int argmax(List<double> values) {

  int maxIndex = 0;
  double maxValue = values[0];

  for (int i = 1; i < values.length; i++) {
    if (values[i] > maxValue) {
      maxValue = values[i];
      maxIndex = i;
    }
  }

  return maxIndex;
}
