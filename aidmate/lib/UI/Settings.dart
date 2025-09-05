import 'package:flutter/material.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:http/http.dart';
import 'package:aidmate/Logic/States/defined_states.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}


class _Settings extends State<Settings> {
  late var max_width, maxHeight;
  double _currentValue_of_tokens = 50;
  double _currentValue_of_temperature = 50;
  THEME selectedtheme = THEME.light;
  MODEL selectedmodel = MODEL.gbt120;


  late SettingsState  provider_settings;

  Widget row_setting(String name, VoidCallback onPress, {IconData? icon}) {
    return InkWell(
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon ?? Icons.smart_toy),
          SizedBox(width: 10,),
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

getSlider(double _currentValue,var on_change){
  return Slider(
    value: _currentValue ,
    min: 0,
    max: 100,
    divisions: 10,
    activeColor: Colors.pink,
    inactiveColor: Colors.grey,
    onChanged: on_change,
  );
}

  Model_Settings() {
    return <Widget>[
      Text(
        "Theme",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      SizedBox(height: 15,),
      row_setting("Dark",(){selectedtheme=THEME.dark;},icon:Icons.dark_mode),
      SizedBox(height: 15,),
      row_setting("Light",(){selectedtheme=THEME.light;},icon: Icons.light_mode),
      SizedBox(height: 15,),
      row_setting("System",(){selectedtheme=THEME.system;},icon: Icons.mobile_friendly),
      SizedBox(height: 15,),
      Divider(  color: Colors.pink, thickness: 1, ),
      SizedBox(height: 15,),
      Text(
        "Model",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      SizedBox(height: 15,),
      row_setting("GPT 120 (Default)",(){selectedmodel=MODEL.gbt120;}),
      SizedBox(height: 15,),
      row_setting("GPT 20",(){selectedmodel=MODEL.gbt20;}),
      SizedBox(height: 15,),
      row_setting("Gemini Flash",(){selectedmodel=MODEL.gemini;}),
      SizedBox(height: 15,),
      Divider(  color: Colors.pink, thickness: 1, ),
      SizedBox(height: 15,),
      Text(
        "Model Configuration (Advanced)",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      SizedBox(height: 15,),
      Text("Number of Tokens",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      SizedBox(height: 8,),
      getSlider(_currentValue_of_tokens,(value) {setState(() {_currentValue_of_tokens  = value; });}),
      SizedBox(height: 15,),
      Text("Model Temperature",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      SizedBox(height: 8,),
      getSlider(_currentValue_of_temperature,(value) {setState(() {_currentValue_of_temperature  = value; });}),

    ];
  }
SaveButton() async{
  provider_settings.set_n_token(_currentValue_of_tokens.toInt()*20);
  provider_settings.set_temperature(_currentValue_of_temperature/50.0);
  provider_settings.set_model(selectedmodel);
  provider_settings.set_theme(selectedtheme);

  await SaveSettings();


}
  SaveSettings() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('max_token', _currentValue_of_tokens.toInt()*20);
    await prefs.setDouble('temperature',_currentValue_of_temperature/50.0);
    await prefs.setString('model',selectedmodel.name);
    await prefs.setString('theme',selectedtheme.name);

  }
  @override
  Widget build(BuildContext context) {

    provider_settings = Provider.of<SettingsState>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        max_width = constraints.maxWidth;
        maxHeight = constraints.maxHeight;
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text("الأعدادات")),
            flexibleSpace: getGradientPlace(null,provider_settings, grad_: grad_dark_pink),
          ),
          body: getGradientPlace(
            Padding(
              padding: EdgeInsets.all(max_width / 25),
              child: SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: Model_Settings()
              ),
            )),provider_settings,
            shouldExpand: true,
          )
        ,bottomNavigationBar: ElevatedButton(onPressed: SaveButton, child: Text("حفظ")));
      },
    );
  }
}
