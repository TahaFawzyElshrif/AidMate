import 'package:aidmate/Logic/States/defined_states.dart';
import 'package:flutter/material.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class Disclaimer extends StatefulWidget {
  @override
  _Disclaimer createState() => _Disclaimer();
}

class _Disclaimer extends State<Disclaimer> {
  String disclaimer_txt = "";

  @override
  void initState() {
    super.initState();
    loadMarkdown();
  }

  Future<void> loadMarkdown() async {
    final data = await rootBundle.loadString('assets/data/disclaimer.md');
    setState(() {
      disclaimer_txt = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var settings_provider = Provider.of<SettingsState>(context);
    return getGradientPlace(
      Padding(
        padding: EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl, // يجعل النص يبدأ من اليمين
            child: MarkdownBody(
              data: disclaimer_txt,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(fontSize: 18, color: Colors.black),
                // normal text
                h1: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      settings_provider,
      shouldExpand: true,
    );
  }
}
