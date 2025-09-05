import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aidmate/Logic/Chat_Caller.dart';
import 'package:aidmate/Logic/HiveC.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:aidmate/UI/global_elements.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:aidmate/Logic/States/defined_states.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _Chat();
}

class _Chat extends State<Chat> {
  late String current_chat_id;
  String mode = MODE_ONLINE;
  late var max_width, maxHeight;
  List<Map<String, String>> messages = []; // Remove late, initialize directly

  final TextEditingController Messages_write_controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late var messages_state_;
  late SettingsState settings_state;

  bool _isLoading = false; // Add loading state

  @override
  void initState() {
    super.initState();
    // Initialize current_chat_id immediately
    current_chat_id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    messages_state_ = Provider.of<messages_state>(context, listen: false); // Add listen: false
    settings_state = Provider.of<SettingsState>(context, listen: false);

    if (messages_state_.chat_id != null) {
      current_chat_id = messages_state_.chat_id;
      _loadMessages();
    } else {
      _initializeNewChat();
    }
  }

  Future<void> _initializeNewChat() async {
    try {
      await add_chat(current_chat_id, []);
      print('New chat initialized: $current_chat_id');
    } catch (e) {
      print('Error initializing chat: $e');
    }
  }

  Future<void> _loadMessages() async {
    try {
      List<Map<String, String>> savedMessages = await get_chat(current_chat_id);
      if (mounted) { // Check if widget is still mounted
        setState(() {
          messages = savedMessages ?? []; // Handle null case
        });
        print('Loaded ${messages.length} messages');
      }
    } catch (e) {
      print('Error loading messages: $e');
      if (mounted) {
        setState(() {
          messages = [];
        });
      }
    }
  }

  bool _is_user(var new_message) {
    return (new_message["role"] == "user");
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && mounted) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _send_message() async {
    final messageText = Messages_write_controller.text.trim();

    if (messageText.isEmpty || _isLoading) {
      return; // Don't send empty messages or if already loading
    }

    print('Sending message: $messageText');

    // Clear input immediately
    Messages_write_controller.clear();

    // Set loading state
    setState(() {
      _isLoading = true;
    });

    try {
      // Create user message
      final userMessage = {
        "role": "user",
        "content": messageText,
      };

      // Add user message to UI immediately
      setState(() {
        messages = [...messages, userMessage]; // Create new list to ensure rebuild
      });

      print('Messages count after adding user message: ${messages.length}');
      _scrollToBottom();

      // Save user message to storage
      await addMessage(current_chat_id, userMessage);
      print('User message saved to storage');

      // Get AI response with current messages
      final currentMessages = List<Map<String, String>>.from(messages);
      final chatCallerResponse = await chat_caller(currentMessages, settings_state);

      if (chatCallerResponse != null && chatCallerResponse.length >= 2) {
        final newMode = chatCallerResponse[0] ?? mode;
        final response = chatCallerResponse[1] ?? "Error: No response";

        final systemMessage = {
          "role": "system",
          "content": response
        };

        // Add system response to UI
        if (mounted) {
          setState(() {
            mode = newMode;
            messages = [...messages, systemMessage]; // Create new list
          });

          print('Messages count after adding system message: ${messages.length}');
          _scrollToBottom();

          // Save system message to storage
          await addMessage(current_chat_id, systemMessage);
          print('System message saved to storage');
        }
      } else {
        print('Invalid chat_caller response: $chatCallerResponse');
      }

    } catch (e) {
      print('Error in _send_message: $e');

      // Show error message to user
      if (mounted) {
        setState(() {
          messages = [...messages, {
            "role": "system",
            "content": "Sorry, there was an error processing your message. Please try again."
          }];
        });
        _scrollToBottom();
      }
    } finally {
      // Reset loading state
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Row _getChatBottomRow() {
    var decoration_of_text = const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      border: InputBorder.none,
      hintText: "Type your message...",
    );
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: Messages_write_controller,
            decoration: decoration_of_text,
            enabled: !_isLoading, // Disable when loading
            onSubmitted: (_) => _send_message(), // Allow enter to send
          ),
        ),
        IconButton(
          icon: _isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : const Icon(Icons.send),
          onPressed: _isLoading ? null : _send_message,
        ),
      ],
    );
  }

  Widget _single_message_text(String message) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: MarkdownBody(data: message),
      ),
    );
  }

  Widget _rowMessage(String message, bool usr_sender) {
    Widget column_msg_sender(CrossAxisAlignment alignment, String name, TextAlign textAlign) {
      return
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: alignment,
            children: [
              Text("\t$name", textAlign: textAlign),
              _single_message_text(message),
            ],
          ),
        )
      ;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: usr_sender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: usr_sender
            ? [
          SizedBox(
            width: max_width / 2,
            child: column_msg_sender(
              CrossAxisAlignment.end,
              "You",
              TextAlign.left,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.person),
        ]
            : [
          const Icon(Icons.smart_toy),
          const SizedBox(width: 10),
          SizedBox(
            width: max_width / 2,
            child: column_msg_sender(
              CrossAxisAlignment.start,
              "AidMate ${settings_state.model.name}",
              TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessages() {
    if (messages.isEmpty) {
      return const Center(
        child: Text(
          "Start a conversation!",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final content = message["content"] ?? "";

        if (content.isEmpty) {
          return const SizedBox.shrink(); // Skip empty messages
        }

        return _rowMessage(
          content,
          _is_user(message),
        );
      },
    );
  }

  Widget getAppBar() {
    return Column(
      children: [
        Logo(),
        const SizedBox(height: 4),
        Text(
          "$mode  $current_chat_id",
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        max_width = constraints.maxWidth;
        maxHeight = constraints.maxHeight;

        return Scaffold(
          appBar: AppBar(
            title: Center(child: getAppBar()),
            flexibleSpace: getGradientPlace(
                null,
                settings_state,
                grad_: grad_dark_pink
            ),
          ),
          body: getGradientPlace(
            Padding(
              padding: EdgeInsets.all(max_width / 25),
              child: buildMessages(),
            ),
            settings_state,
          ),
          bottomNavigationBar: SafeArea(
            child: getGradientPlace(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: max_width / 25),
                child: Card(
                  child: SizedBox(
                    height: maxHeight / 10,
                    child: _getChatBottomRow(),
                  ),
                ),
              ),
              settings_state,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Messages_write_controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}