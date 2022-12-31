import 'dart:convert';
import 'package:intl/intl.dart';
import '../../constants/shared_preference.dart';
import 'sorting_methods.dart';
import '../../constants/styles.dart';

/// Function for getting the first date after 4 weeks from now.
DateTime getLastDate() {
  DateTime finalDate =
      DateFormat("dd.MM.yyyy").parse("25.12.2022"); //DateTime.now();
  int incrementDays = 21;
  if (finalDate.weekday == 7) {
    incrementDays = incrementDays + 7;
  } else {
    incrementDays = incrementDays + (7 - finalDate.weekday);
  }
  finalDate = finalDate.add(Duration(days: incrementDays));
  return finalDate;
}

/// Function for getting the week data
List getWeekInformation(DateTime date, int weekday) {
  Map<String, dynamic> data = <String, dynamic>{};
  int dayOfYear = int.parse(DateFormat("D").format(date));
  int week = 0;
  DateTime startDate, endDate;
  if (weekday == 7) {
    week = (((dayOfYear - date.weekday + 10) / 7).floor() + 1);
    startDate = date;
    endDate = date.add(const Duration(days: 6));
  } else {
    week = ((dayOfYear - date.weekday + 10) / 7).floor();
    startDate = date.subtract(Duration(days: weekday));
    endDate = date.add(Duration(days: (6 - weekday)));
  }
  data['week'] = week;
  data['startYear'] = startDate.year;
  data['endYear'] = endDate.year;
  data['startMonth'] = getWordMonth(startDate.month);
  data['endMonth'] = getWordMonth(endDate.month);
  data['startDay'] = startDate.day;
  data['endDay'] = endDate.day;
  data['days'] = newDays;
  return [week, data];
}

/// Function for converting string month value to integer.
int getNumericMonth(String month) {
  switch (month) {
    case 'JAN':
      return 1;
    case 'FEB':
      return 2;
    case 'MAR':
      return 3;
    case 'APR':
      return 4;
    case 'MAY':
      return 5;
    case 'JUN':
      return 6;
    case 'JUL':
      return 7;
    case 'AUG':
      return 8;
    case 'SEP':
      return 9;
    case 'OCT':
      return 10;
    case 'NOV':
      return 11;
    case 'DEC':
      return 12;
  }
  return 0;
}

/// Function for converting numeric month value to string.
String getWordMonth(int month) {
  switch (month) {
    case 1:
      return 'JAN';
    case 2:
      return 'FEB';
    case 3:
      return 'MAR';
    case 4:
      return 'APR';
    case 5:
      return 'MAY';
    case 6:
      return 'JUN';
    case 7:
      return 'JUL';
    case 8:
      return 'AUG';
    case 9:
      return 'SEP';
    case 10:
      return 'OCT';
    case 11:
      return 'NOV';
    case 12:
      return 'DEC';
  }
  return 'JAN';
}

String getFourWeeksInformation() {
  int week = 0;
  List list = [];
  DateTime date = DateTime.now(), startDate, endDate;
  for (int i = 0; i < 4; i++) {
    Map<String, dynamic> newWeekData = <String, dynamic>{};
    int weekday = date.weekday;
    int dayOfYear = int.parse(DateFormat("D").format(date));
    if (weekday == 7) {
      week = (((dayOfYear - date.weekday + 10) / 7).floor() + 1);
      startDate = date;
      endDate = date.add(const Duration(days: 6));
    } else {
      week = ((dayOfYear - date.weekday + 10) / 7).floor();
      startDate = date.subtract(Duration(days: weekday));
      endDate = date.add(Duration(days: (6 - weekday)));
    }
    newWeekData['week'] = week;
    newWeekData['startYear'] = startDate.year;
    newWeekData['endYear'] = endDate.year;
    newWeekData['startMonth'] = getWordMonth(startDate.month);
    newWeekData['endMonth'] = getWordMonth(endDate.month);
    newWeekData['startDay'] = startDate.day;
    newWeekData['endDay'] = endDate.day;
    newWeekData['days'] = newDays;
    list.add(newWeekData);
    date = date.add(const Duration(days: 7));
  }
  return jsonEncode(list);
}

void restWeekData() async {
  DateTime date = DateTime.now();
  if (date.weekday == 7) {
    if (await checkSharedPreferencesData()) {
      bool weekExists = false;
      String data = await getSharedPreferencesData();
      List list = jsonDecode(data);
      list.removeAt(0);
      date = date.add(const Duration(days: 24));
      int dayOfYear = int.parse(DateFormat("D").format(date));
      int week = ((dayOfYear - date.weekday + 10) / 7).floor();
      for(int index=0;index<list.length;index++) {
        if(list[index]['week']==week){
          weekExists = true;
          break;
        }
      }
      if(!weekExists){
        List newWeek = getWeekInformation(date, date.weekday);
        String finalData = await returnNewData(newWeek[0], newWeek[1]);
        setSharedPreferencesData(finalData);
      }
    }
  }
}
