import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameInKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailInKey = "USEREMAILKEY";

  // saving data to SharedPreference

  static Future<void> saveUserLoggedIn(
    bool isUserLoggedIn,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUsername(
    String username
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPreferenceUserNameInKey, username);
  }

 static Future<void> saveUserEmail(
    String email
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPreferenceUserEmailInKey, email);
  }

  // get data

static Future<void> getUserLoggedIn(
    bool isUserLoggedIn,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<void> getUsername(
    String username
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(sharedPreferenceUserNameInKey);
  }

 static Future<void> getUserEmail(
    String email
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(sharedPreferenceUserEmailInKey);
  }

}
