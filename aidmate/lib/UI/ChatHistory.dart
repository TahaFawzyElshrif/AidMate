import 'package:flutter/material.dart';
import 'package:aidmate/Logic/HiveC.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:provider/provider.dart';
import 'package:aidmate/Logic/States/defined_states.dart';
import 'package:aidmate/UI/Chat.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistory();
}

class _ChatHistory extends State<ChatHistory> {
  late var messages_state_;
  var data_chat = "";

  deleteChat(var id) {
    setState(() {
      deleteChatHive(id);
    });
  }

  chat_row(String id, String datetime) {
    return Padding(
      padding: EdgeInsets.all(20),
      child:
         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.chat, size: 30),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text(datetime),
              ],
            ),
            SizedBox(width: 15),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => deleteChat(id),
                icon: Icon(Icons.delete),
              ),
            ),
          ],
        ),
      )
    ;
  }

  goToChat(var chat, var context) {
    messages_state_.set_chat_id(chat);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(),
      ), //builder is parameter take lambda function
    );
  }

  inner_chats(List<String> chats, var context) {
    messages_state_ = Provider.of<messages_state>(context);

    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topRight,
          child: Column(
            children: chats.map((chat) {
              return SizedBox(
                height: 100,
                child: ElevatedButton(
                  onPressed: () => goToChat(chat, context),
                  child: chat_row(chat, data_chat),
                ),
              );
            }).toList().reversed.toList(),
          ),
        ),
      ),
    );
  }

  make_future_builder(var inner_function, var context) {
    return FutureBuilder<List<String>>(
      future: getChatIDs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No chats found'));
        }

        final chats = snapshot.data!;
        return inner_function(chats, context);
      },
    );
  }

  Widget build(BuildContext context) {
    SettingsState settings_state = Provider.of<SettingsState>(context);
    return getGradientPlace(
      make_future_builder(inner_chats, context),
      settings_state,
      shouldExpand: true,
    );
  }
}
