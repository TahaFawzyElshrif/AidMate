import 'package:aidmate/Logic/States/defined_states.dart';
import 'package:flutter/material.dart';
import 'package:aidmate/UI/Login.dart';
import 'package:aidmate/Logic/Accounts.dart';
import 'package:aidmate/UI/DefaultFragmentChooser.dart';
import 'package:aidmate/Backgrounds/gradients.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  static const padding_between = 15.0;
  bool _hideText = true;
  bool _hideText_confirm = true;

  var _username_controller = TextEditingController();
  var _email_controller = TextEditingController();
  var _password_controller = TextEditingController();
  var _password_repeat_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SettingsState settings_state = Provider.of<SettingsState>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return
           Scaffold(
            appBar: AppBar(title: Text('انشاء حساب'),flexibleSpace: Container(
            decoration: BoxDecoration(
            gradient: grad_containers,
            ),)),
            body: getGradientPlace(ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
              child: SingleChildScrollView(

                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(padding_between),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // Important!
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(padding_between),
                          child: Text(
                            "الاسم",
                            textAlign: TextAlign.right,
                            style: TextStyle(

                              fontWeight: FontWeight.bold, // Bold text
                              fontSize: 13,
                            ),
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
                              controller: _username_controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                labelText: "ادخل اسمك",

                              ),
                            ),
                          ),
                        ),
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
                              controller: _password_controller,
                              obscureText: _hideText,
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                labelText: "انشأ كلمة مرور",
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
                        Padding(
                          padding: const EdgeInsets.all(padding_between),
                          child: Text(
                            "اعد كلمة المرور",
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
                              controller: _password_repeat_controller,
                              obscureText: _hideText_confirm,
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                labelText: "اعد كلمة المرور",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _hideText_confirm
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _hideText_confirm = !_hideText_confirm;
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
            ),settings_state,grad_:grad_back,shouldExpand: true),
            bottomNavigationBar:getGradientPlace(SafeArea(child: Padding(
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
                          var check_result = await createAccountAndGo(_username_controller.text,_email_controller.text,_password_controller.text,_password_repeat_controller.text);
                          if (check_result.startsWith("Done")){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DefaultFragmentChooser()), //builder is parameter take lambda function
                            );
                          }else{
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("خطا"),
                                  content: Text("يرجى التخقق من البيانات \n"+check_result),
                                  actions: [
                                    TextButton(
                                        child: Text("OK"),
                                        onPressed: () {}

                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text("أنشأ الحساب"),
                      ),
                    ),
                  ),
                  Text("لديك حساب بالفعل؟"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()), //builder is parameter take lambda function
                      );

                    },
                    child: Text(
                      "سجل دخول",
                      style: TextStyle(
                        color: Colors.blue, // Make it look like a link
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
                )),settings_state,grad_:grad_back,shouldExpand: false));

      },
    );
  }

}
