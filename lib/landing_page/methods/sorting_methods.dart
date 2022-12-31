import 'dart:convert';
import '../../constants/shared_preference.dart';

Future<String> returnNewData(
    int insertionWeek, Map<String, dynamic> newData) async {
  int counter = 0;
  bool weekExists = false, insertLast = false;
  String json = await getSharedPreferencesData();
  List list = jsonDecode(json);

  for (int index = 0; index < list.length; index++) {
    int listWeek = list[index]['week'];
    if (insertionWeek == listWeek) {
      counter = index;
      weekExists = true;
      break;
    }
    if (insertionWeek > listWeek && listWeek < 48) {
      counter = index;
    }
    if (insertionWeek < listWeek && listWeek < 48) {
      break;
    }
    if (index == list.length - 1) {
      insertLast = true;
    }
  }
  if (weekExists) {
    list.removeAt(counter);
    list.insert(counter, newData);
  } else {
    if (insertLast) {
      list.add(newData);
    } else {
      list.insert(counter + 1, newData);
    }
  }
  return jsonEncode(list);
}
