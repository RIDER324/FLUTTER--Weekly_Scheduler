import '../landing_page/methods/date_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

checkSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('list');
}

getSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = "";
  if (!prefs.containsKey('list')) {
    await setSharedPreferencesData(getFourWeeksInformation());
  }
  stringValue = prefs.getString('list') ?? "";
  return stringValue;
}

setSharedPreferencesData(String list) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool success = await prefs.setString('list', list);
  return success;
}

checkSharedPreferencesName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('name');
}

getSharedPreferencesName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('name') ?? "";
}

setSharedPreferencesName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool success = await prefs.setString('name', name);
  return success;
}

clearSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('list');
  prefs.remove('name');
}