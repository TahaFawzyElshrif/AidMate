import 'package:aidmate/Logic/States/defined_states.dart';
import 'package:flutter/material.dart';

var color_pink = 0xFFD90368;
var color_dark_pink = 0xFF820263;
var color_white = 0xFFeadeda;
var color_cadet = 0xFF2e294e;
var color_gold = 0xFFffd400;

var grad_containers = SweepGradient(
  colors: [Color(color_cadet), Color(color_dark_pink), Color(color_pink)],
  center: Alignment.center,
);

var grad_back = RadialGradient(
  colors: [Color(color_pink), Color(color_dark_pink)],
  center: Alignment.center,
  radius: 0.9,
);

var grad_cadet = LinearGradient(
  colors: [Color(color_cadet), Color(color_white)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

var grad_dark_pink = LinearGradient(
  colors: [Color(color_dark_pink), Color(color_white)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

var grad_pink = LinearGradient(
  colors: [Color(color_pink), Color(color_white)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

Container getGradientPlace(
  Widget? child_,
  SettingsState setting_state,{
  bool shouldExpand = false,
  Gradient? grad_,
}) {
  return Container(
    width: shouldExpand ? double.infinity : null,
    height: shouldExpand ? double.infinity : null,
    decoration: BoxDecoration(gradient: grad_ ?? get_theme(setting_state)),
    child: child_,
  );
}

get_theme(SettingsState setting_state){
  if (setting_state.theme==(THEME.light)){
    return grad_pink;

  }else if (setting_state.theme==(THEME.dark)){
    return grad_dark_pink;

  }else{
    return grad_cadet;
  }
}

