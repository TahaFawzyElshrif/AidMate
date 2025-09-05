import 'package:flutter/material.dart';
import 'package:aidmate/UI/DefaultFragmentChooser.dart';
import 'package:aidmate/UI/Login.dart';
import 'package:aidmate/Logic/HiveC.dart';
import 'package:provider/provider.dart';
import 'package:aidmate/Logic/States/defined_states.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await intialize_Hive();

  runApp(providers(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(locale: const Locale('ar'), home: RootLoader());
  }
}

class RootLoader extends StatefulWidget {
  const RootLoader({super.key});

  @override
  State<RootLoader> createState() => _RootLoaderState();
}

class _RootLoaderState extends State<RootLoader> {
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getRootWidget(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('Error loading app')));
        } else {
          return snapshot.data!;
        }
      },
    );
  }

  Future<Widget> getRootWidget(var context) async {
    // go just to fragment if login ,otherwise login

    bool found_sessions = await readSessions();
    if (found_sessions) {
      await LoadSettings(context);
      return DefaultFragmentChooser();
    } else {
      return Login();
    }
  }

  Future<bool> readSessions() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(
      'email',
    ); //version 1 only store and check mail

    return email != null;
  }

  Future<void> LoadSettings(var context) async {
    final prefs = await SharedPreferences.getInstance();
    int max_token = prefs.getInt('max_token') ?? 1000;
    double temperature = prefs.getDouble('temperature') ?? 1;
    String model = prefs.getString('model') ?? 'gbt120';
    String theme = prefs.getString('theme') ?? 'light';

    var Settings_provider = Provider.of<SettingsState>(context, listen: false);
    Settings_provider.set_n_token(max_token);
    Settings_provider.set_temperature(temperature);

    Settings_provider.set_model(model);
    Settings_provider.set_theme(theme);
  }
}

providers(var child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => messages_state()),
      ChangeNotifierProvider(create: (_) => UserState()),
      ChangeNotifierProvider(create: (_) => SettingsState()),
    ],
    child: child,
  );
}
