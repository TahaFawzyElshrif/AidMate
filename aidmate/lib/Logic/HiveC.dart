import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final  String CHAT_BOX = "Chats";

Future<void> intialize_Hive() async{
  await Hive.initFlutter();
  await Hive.openBox(CHAT_BOX);
}

Future<void> add_chat(String id , List<Map<String, String>>  messages) async{
  //    {"role": "user", "content": "مرحبا"},
  var box = await Hive.openBox(CHAT_BOX);
  await box.put(id, messages);
}

Future<List<Map<String, String>>> get_chat(String id) async{
  var box = await Hive.openBox(CHAT_BOX);
  List<Map<String, String>> messages = box.get(id,defaultValue: []);
  return messages.map((e) => Map<String, String>.from(e)).toList();
}

void deleteChatHive(String chatId) async {
  var box = await Hive.openBox(CHAT_BOX);
  await box.delete(chatId);

}


Future<void> addMessage(String chatId, Map<String, String> newMessage) async {
  var box = await Hive.openBox(CHAT_BOX);
  List<Map<String, String>> messages = box.get(chatId, defaultValue: []);
  messages.add(newMessage);
  await box.put(chatId, messages);
}

Future<List<String>> getChatIDs() async{
    var box = Hive.box(CHAT_BOX);
    List<String> chatIds = box.keys.cast<String>().toList();
    return chatIds;
}