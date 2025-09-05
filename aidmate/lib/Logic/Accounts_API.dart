import 'package:http/http.dart' as http;
import 'dart:convert';

const String ACCOUNTS_BASE_URL =  "https://taha454-aidmateaccount.hf.space";
const String signup_url = "$ACCOUNTS_BASE_URL/register";
const String login_url = "$ACCOUNTS_BASE_URL/login";
const String done_str = "Done";


Future<String> login(String email , String password) async{
  // Start with Done if ok ,or just say error if not
  var url = Uri.parse(login_url);

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    // Parse the response
    final data = jsonDecode(response.body);
    return done_str + data.toString();
  } else {
    return "فشل تسجيل الدخول: ${response.body}";
  }

}

Future<String> signup(String username,String email , String password) async{
  // Start with Done if ok ,or just say error if not
  var url = Uri.parse(signup_url);

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "username": username,
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    // Parse the response
    final data = jsonDecode(response.body);
    return done_str + data.toString();
  } else {
    return "فشل تسجيل الدخول: ${response.body}";
  }

}