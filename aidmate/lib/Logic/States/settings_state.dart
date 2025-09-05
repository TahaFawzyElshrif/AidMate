import 'package:flutter/material.dart';
const MODE_ONLINE = "اونلاين";
const MODE_OFFLINE = "اوفلاين";

enum THEME { light, dark, system }
enum MODEL {gbt120,gbt20,gemini}


class SettingsState with ChangeNotifier {
  THEME theme = THEME.light;
  MODEL model = MODEL.gbt120;
  int n_token = 1000;
  double temperature = 1.0;




  void set_theme(dynamic x) {
    if (x is String) {
      theme = THEME.values.firstWhere(
            (e) => e.name == x,
        orElse: () => THEME.light,
      );
    } else if (x is THEME) {
      theme = x;
    }
    notifyListeners();
  }

  void set_model(dynamic x) {
    if (x is String) {
      model = MODEL.values.firstWhere(
            (e) => e.name == x,
        orElse: () => MODEL.gbt120,
      );
    } else if (x is MODEL) {
      model = x;
    }
    notifyListeners();
  }
  void set_n_token(int x){
    n_token=x;
    notifyListeners();
  }
  void set_temperature(double x){
    temperature=x;
    notifyListeners();
  }
}

