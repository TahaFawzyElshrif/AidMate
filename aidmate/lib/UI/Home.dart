import 'package:aidmate/Logic/States/defined_states.dart';
import 'package:flutter/material.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:aidmate/UI/Chat.dart';
import 'package:aidmate/UI/ChatHistory.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:aidmate/UI/Settings.dart';
import 'package:aidmate/UI/Home.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  late double maxHeight, max_width;
  late var settings_state;

  Home_Single_Element(String text, VoidCallback onPress, IconData icon) {
    return Expanded(child: InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(15.0), // spacing inside
        child: SizedBox(
          width: max_width / 5,
          height: maxHeight / 10,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: getGradientPlace(
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(icon), SizedBox(width: 12), Text(text)],
              ),settings_state,
              grad_: grad_dark_pink,
              shouldExpand: true,
            ),
          ),
        ),
      ),
    ));
  }
goToPage(var context,var page){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ), //builder is parameter take lambda function
  );
}
  Home_Elements(var context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Home_Single_Element("Chat", ()=>goToPage(context,Chat()), Icons.chat),
            Home_Single_Element("Disclaimer", () =>goToPage(context,Chat()), Icons.info),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Home_Single_Element("Emergency", ()=>goToPage(context,Chat()), Icons.emergency),
            Home_Single_Element("Settings", ()=>goToPage(context,Settings()), Icons.settings),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
     settings_state = Provider.of<SettingsState>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        max_width = constraints.maxWidth;
        maxHeight = constraints.maxHeight;

        return Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text("Quick Actions"),
            ),
            flexibleSpace: getGradientPlace(null, settings_state,grad_: grad_dark_pink),
          ),
          body: getGradientPlace(
            Center(child: Home_Elements(context)),
            settings_state,
            shouldExpand: true,
          ),
        );
      },
    );
  }
}
