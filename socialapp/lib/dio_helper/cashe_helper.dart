// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences shared_pref;

  static init() async {
    shared_pref = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
      {required String key, required bool value}) async {
    return await shared_pref.setBool(key, value);
  }

  static dynamic getDate({required String key}) {
    return shared_pref.get(key);
  }

  // static dynamic getDate2({required String key}) {
  //   return shared_pref.get(key);
  // }

  static Future<bool> savedata(
      {required String key, required dynamic value}) async {
    if (value is String) return await shared_pref.setString(key, value);
    if (value is bool) return await shared_pref.setBool(key, value);
    if (value is int)
      return await shared_pref.setInt(key, value);
    else
      return await shared_pref.setDouble(key, value);
  }

  static Future<bool> removedata(String key) async {
    return await shared_pref.remove(key);
  }
}
