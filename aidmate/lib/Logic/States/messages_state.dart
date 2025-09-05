import 'package:flutter/material.dart';

class messages_state with ChangeNotifier {
  String? chat_id;


  void set_chat_id(String? x){
    chat_id=x;
    notifyListeners();

  }
}

