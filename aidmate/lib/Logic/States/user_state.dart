import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String user_name= "USER";
  String email= "email@gmail.com";

  void set_user(String user_){
    user_name=user_;
    notifyListeners();

  }
  void set_email(String mail){
    email=mail;
    notifyListeners();
  }
}

