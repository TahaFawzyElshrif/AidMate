import 'package:flutter/material.dart';
import 'package:aidmate/UI/Chat.dart';
import 'package:aidmate/UI/ChatHistory.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:aidmate/UI/Settings.dart';
import 'package:aidmate/UI/Home.dart';
import 'package:aidmate/Logic/States/defined_states.dart';
import 'package:provider/provider.dart';
import 'package:aidmate/UI/Disclaimer.dart';

class DefaultFragmentChooser extends StatefulWidget {
  const DefaultFragmentChooser({super.key});

  @override
  State<DefaultFragmentChooser> createState() => _BottomTabsExampleState();
}

class _BottomTabsExampleState extends State<DefaultFragmentChooser>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
var provider_message;
var provider_settings;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
goToChat(){
  provider_message.set_chat_id(null);
    return Chat();
}
  @override
  Widget build(BuildContext context) {
    provider_message = Provider.of<messages_state>(context);
    provider_settings =Provider.of<SettingsState>(context);
    return Scaffold(
      body: TabBarView(

        controller: _tabController,
        children:  [
          Home(),
          goToChat(),
          ChatHistory(),
          getGradientPlace(Center(child: Text("عفوا هذه الخاصية غير متاحة الان")),provider_settings,shouldExpand: true),
          Settings(),
          Disclaimer(),

        ],
      ),
      bottomNavigationBar: getGradientPlace(BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabController.index,
        onTap: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "ALL Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.emergency), label: "Emergency"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Disclaimer"),

        ],
      ),provider_settings,
    grad_: grad_cadet)
    );
  }
}
