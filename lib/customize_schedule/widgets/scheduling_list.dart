// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'day_button.dart';
import 'hour_button.dart';
import '../../constants/json_converter.dart';
import '../../constants/styles.dart';
import 'package:flutter/material.dart';

class SchedulingList extends StatefulWidget {
  const SchedulingList({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<SchedulingList> createState() => _SchedulingListState();
}

class _SchedulingListState extends State<SchedulingList> {
  var week;
  bool once = true;
  late Future<String> _data;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    _data = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('list') ?? "";
    });

    super.initState();
  }

  void doDayAction(int index) {
    setState(() {
      week.days[index].available = !week.days[index].available;
      if (week.days[index].available) {
        week.days[index].hours.morning = week.days[index].hours.afternoon =
            week.days[index].hours.evening = true;
      }
    });
  }

  void doHourAction(int index, String hour) {
    setState(() {
      if (hour == 'morning') {
        if (week.days[index].hours.morning &&
            !week.days[index].hours.afternoon &&
            !week.days[index].hours.evening) {
          week.days[index].available = false;
        }
        week.days[index].hours.morning = !week.days[index].hours.morning;
      }
      if (hour == 'afternoon') {
        if (!week.days[index].hours.morning &&
            week.days[index].hours.afternoon &&
            !week.days[index].hours.evening) {
          week.days[index].available = false;
        }
        week.days[index].hours.afternoon = !week.days[index].hours.afternoon;
      }
      if (hour == 'evening') {
        if (!week.days[index].hours.morning &&
            !week.days[index].hours.afternoon &&
            week.days[index].hours.evening) {
          week.days[index].available = false;
        }
        week.days[index].hours.evening = !week.days[index].hours.evening;
      }
    });
  }

  Future<void> onSave(String value) async {
    List list = jsonDecode(value);
    if (list[widget.index]['week'] == week.week) {
      list.removeAt(widget.index);
      Map<String, dynamic> data = <String, dynamic>{};
      data = week.toJson();
      list.insert(widget.index, data);
      String encodedData = jsonEncode(list);
      final SharedPreferences prefs = await _prefs;
      setState(() {
        _data = prefs.setString('list', encodedData).then((bool success) {
          return encodedData;
        });
      });
    }
  }

  void getData(String value) {
    List decodeList = jsonDecode(value);
    String encodeWeekList = jsonEncode(decodeList[widget.index]);
    var data = jsonDecode(encodeWeekList);
    week = Root.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _data,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (once) {
                getData(snapshot.data!);
                once = false;
              }
              return Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: week.days.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext ctx, int index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(borderRadius)),
                          child: Container(
                            padding: EdgeInsets.all(paddingLarge),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DayButton(
                                  dayName: week.days[index].day,
                                  isAvailable: week.days[index].available,
                                  onTap: () => doDayAction(index),
                                ),
                                SizedBox(height: paddingSmall),
                                Divider(
                                  color: disabledColor.withOpacity(0.2),
                                  thickness: 1.5,
                                ),
                                SizedBox(height: paddingSmall),
                                (week.days[index].available)
                                    ? Row(
                                        children: [
                                          HourButton(
                                            text: 'Morning',
                                            isSelected:
                                                week.days[index].hours.morning,
                                            onTap: () =>
                                                doHourAction(index, 'morning'),
                                          ),
                                          SizedBox(width: paddingLarge),
                                          HourButton(
                                            text: 'Afternoon',
                                            isSelected: week
                                                .days[index].hours.afternoon,
                                            onTap: () => doHourAction(
                                                index, 'afternoon'),
                                          ),
                                          SizedBox(width: paddingLarge),
                                          HourButton(
                                            text: 'Evening',
                                            isSelected:
                                                week.days[index].hours.evening,
                                            onTap: () =>
                                                doHourAction(index, 'evening'),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        'Unavailable',
                                        style: TextStyle(
                                            fontSize: heading2,
                                            color: disabledColor),
                                      ),
                              ],
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: paddingMedium),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingSmall),
                    child: Divider(
                      color: disabledColor,
                      thickness: 1.5,
                    ),
                  ),
                  SizedBox(height: paddingMedium),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingSmall),
                    child: ElevatedButton(
                      onPressed: () => onSave(snapshot.data!),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius))),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: heading1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: paddingMedium),
                ],
              );
            }
        }
      },
    );
  }
}
