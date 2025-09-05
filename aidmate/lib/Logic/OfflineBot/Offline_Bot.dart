import 'package:aidmate/Logic/OfflineBot/json_parser.dart';
import 'package:aidmate/Logic/OfflineBot/text_processor.dart';
import 'package:aidmate/Logic/OfflineBot/TfIDF_transformer.dart';
import 'package:aidmate/Logic/OfflineBot/Consine_sim.dart';


Future<String> Offline_Bot(String message) async{
  // Take only final last message , don't process history

  // Load Data
  Map<String, dynamic> vocab_idfs = await loadVocab_IDF();
  List<List<double>> tfidf_matrix = await loadTfidfMatrix();
  List<Map<String, String>> questions_answers = await loadAllQuestionsAnswers();

  List<String> vocab = vocab_idfs['Vocab'];
  List<double> idfs = vocab_idfs['IDF'];

  // Clean text
  List<String> cleaned_prompt_list = preprocessAr(message);
  String cleaned_prompt = cleaned_prompt_list.join(' ');

  // Do tf_idf to prompt and cosine metric
  List<double> tf_idf_of_prompt = transformTfidf(cleaned_prompt,vocab,idfs);
  List<double> cosine_vals= cosineSimilarityOneToMany(tf_idf_of_prompt,tfidf_matrix);
  int idx_largest = argmax(cosine_vals);

  // get final answer
  String answer ="بخصوص سؤالك: "+questions_answers[idx_largest]['question'].toString()+"\n"+ questions_answers[idx_largest]['answer'].toString();


  return answer;

}