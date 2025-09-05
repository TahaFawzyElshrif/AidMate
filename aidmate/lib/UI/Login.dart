import 'package:flutter/material.dart';
import 'package:aidmate/UI/CreateAccount.dart';
import 'package:aidmate/Logic/Accounts.dart';
import 'package:aidmate/UI/DefaultFragmentChooser.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:provider/provider.dart';
import 'package:aidmate/Logic/States/defined_states.dart';

import '../Logic/Accounts_API.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  static const padding_between = 15.0;

  bool _hideText = true;
  var _email_controller = TextEditingController();
  var _password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider_User = Provider.of<UserState>(context);
    var provider_Settings = Provider.of<SettingsState>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(title: const Text('تسجيل دخول'),flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: grad_containers,
            ),
          ),),

          body: getGradientPlace(ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(padding_between),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(padding_between),
                          child: Text(
                            "الايميل",
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Bold text
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.start, // Adapts to LTR or RTL
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(padding_between),
                          child: Card(
                            color: Colors.blueGrey[50],
                            // Light blue-grey background
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextField(
                              controller: _email_controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                labelText: "ادخل ايميلك",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(padding_between),
                          child: Text(
                            "كلمة المرور",
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Bold text
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.start, // Adapts to LTR or RTL
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(padding_between),
                          child: Card(
                            color: Colors.blueGrey[50],
                            // Light blue-grey background
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextField(
                              obscureText: _hideText,
                              controller: _password_controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                labelText: "ادخل كلمة مرورك",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _hideText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _hideText = !_hideText;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),provider_Settings,grad_: grad_back,
              shouldExpand:true),
          bottomNavigationBar: SafeArea(child: getGradientPlace(Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(padding_between),

                    child: SizedBox(
                      width: double.infinity,
                      height: 40,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          // Change button color
                          foregroundColor: Colors.white,
                          // Change text color
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          // Size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              22,
                            ), // Rounded corners
                          ),
                        ),
                        onPressed: () async{
                          var check_result = await checkLoginAndGo(
                            _email_controller.text,
                            _password_controller.text,
                          );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                     check_result,
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                          if( check_result.startsWith(done_str)) {
                            provider_User.set_email(_email_controller.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DefaultFragmentChooser(),
                              ), //builder is parameter take lambda function
                            );
                          }
                        },
                        child: Text("سجل دخول"),
                      ),
                    ),
                  ),
                  Text("ليس لديك حساب؟"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccount(),
                        ), //builder is parameter take lambda function
                      );
                    },
                    child: Text(
                      "انشأ حساب",
                      style: TextStyle(
                        color: Colors.blue, // Make it look like a link
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),provider_Settings,grad_: grad_back
          ),
        ));
      },
    );
  }
}
