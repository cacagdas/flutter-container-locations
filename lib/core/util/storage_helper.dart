import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  static const String loggedIn = "LOGGED_IN";
}

class StorageHelper {
  static late SharedPreferences _prefs;

  static Future<dynamic> _getInstance() async =>
      _prefs = await SharedPreferences.getInstance();

  static Future<String?> get(String key) async {
    await _getInstance();
    return _prefs.getString(key);
  }

  static Future<bool?> getBool(String key) async {
    await _getInstance();
    return _prefs.getBool(key);
  }

  static void set(String key, dynamic value) async {
    await _getInstance();
    _prefs.setString(key, value);
  }

  static void setBool(String key, dynamic value) async {
    await _getInstance();
    _prefs.setBool(key, value);
  }

  static void remove(String key) async {
    await _getInstance();
    _prefs.remove(key);
  }

  static void clear() async {
    await _getInstance();
    _prefs.clear();
  }
}
