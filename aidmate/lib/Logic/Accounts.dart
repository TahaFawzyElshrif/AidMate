import 'package:aidmate/Logic/Accounts_API.dart';
import 'package:shared_preferences/shared_preferences.dart';

 Future<String> checkLoginAndGo(String email , String password) async{

  // Start with Done if ok (then details of login) ,or just say error if not
  String check_input = _check_input(email, password);
  if (!check_input.startsWith(done_str)){
    return check_input;
  }

  String login_results=await login(email,password);
  if(!login_results.startsWith(done_str)){
    return login_results;
  }

  await _store_email(email);

  return done_str + login_results;

}



Future<String> createAccountAndGo(String username,String email , String password,String confirm_password) async{
  // Start with Done if ok ,or just say error if not
  String check_input = _check_input(email, password,username: username,coPass:confirm_password);
  if (!check_input.startsWith(done_str)){
    return check_input;
  }

  String signup_results=await signup(username,email,password);
  if(!signup_results.startsWith(done_str)){
    return signup_results;
  }

  return signup_results;
}

_store_email(var email) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}


_check_input(String email , String password,{String? username,String? coPass}){
  if (email.isEmpty){
    return "ادخل الايميل";
  }
  else if (password.isEmpty){
    return "كلمة المرور غير موجودة";
  }
  else if (username != null && username.isEmpty) {
    return "ادخل اسمك";
  } else if (coPass != null && coPass.isEmpty) {
    return "ادخل اعادة كلمة المرور";
  }
  else if (! RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
    return "بريد الكترونى غير صالح";
  }else if (password.length<6){
    return "كلمة المرور على الاقل 6 حروف";
  }else if (coPass != null && coPass != password) {
    return "ادخل اعادة كلمة المرور بشكل صحيح";
  }
  return done_str;

}