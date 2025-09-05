import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aidmate/Logic/States/defined_states.dart';

const String base_url= "https://taha454-aidmatellm.hf.space";
const String chat_url = base_url+"/chat";

Future<String> send_to_api_and_retrive_answer(List<Map<String, String>> messages,SettingsState settings_State) async {
  // Your FastAPI endpoint URL
  var url = Uri.parse(chat_url); // Change to your server address
  Map<String, dynamic> params = {
    'model': settings_State.model.name,
    'max_token': settings_State.n_token,
    'temperature': settings_State.temperature,
  };

  try {
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'messages': messages,
        'parameters': params,
      }), // Convert List<Map<String, String>> to JSON
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['response']; // Return the 'response' from FastAPI
    } else {
      return "Error: ${response.statusCode}";
    }
  } catch (e) {
    return "Exception: $e";
  }
}