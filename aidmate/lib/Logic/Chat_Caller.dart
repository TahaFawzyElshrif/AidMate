import 'dart:convert';
import 'package:aidmate/Logic/HiveC.dart';
import 'package:http/http.dart' as http;
import 'package:aidmate/Logic/OfflineBot/Offline_Bot.dart';
import 'package:aidmate/Logic/Online_API_Caller.dart';
import 'dart:io';
import 'package:aidmate/Logic/States/defined_states.dart';

Future<bool> hasInternet() async {
  try {
    final result = await InternetAddress.lookup(Uri.parse(base_url).host).timeout( const Duration(seconds: 7));
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}

Future<List<String>> chat_caller (List<Map<String, String>> messages,SettingsState settings_State) async {
  bool internet_State = await hasInternet();
  if (internet_State){
      return [MODE_ONLINE,await send_to_api_and_retrive_answer(messages,settings_State)];
  }else{
      return [MODE_OFFLINE,await Offline_Bot(messages.last['content'].toString())];

  }

}

