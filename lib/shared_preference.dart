import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static String userLogInKey = 'ISLOGGEDIN';
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';

  // TODO : save data ke Shared Preference

  static Future<bool> saveLogIn(bool isUserLoggin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(userLogInKey, isUserLoggin);   
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userNameKey, userName);   
  }

  static Future<bool> saveEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userEmailKey, userEmail);   
  }

  // TODO : get data dari Shared Preference

  static Future<bool> getLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(userLogInKey);   
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(userNameKey);   
  }

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(userEmailKey);   
  }
}
