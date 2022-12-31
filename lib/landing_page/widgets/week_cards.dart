import 'dart:convert';
import '../view/landing.page.dart';
import '../../constants/styles.dart';
import '../methods/generate_text.dart';
import 'package:flutter/material.dart';
import '../../constants/json_converter.dart';
import '../../customize_schedule/view/scheduling.page.dart';

class WeekCards extends StatelessWidget {
  const WeekCards({
    Key? key,
    required this.jsonData,
    required this.requestChange,
    required this.userName,
  }) : super(key: key);
  final String jsonData;
  final String userName;
  final CallBack requestChange;

  List getData() {
    List list = json.decode(jsonData);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List list = getData();
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(paddingMedium),
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var json = jsonEncode(list[index]);
          var map = jsonDecode(json);
          var week = Root.fromJson(map);
          return Column(
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (week.week! < 10)
                                    ? 'Week 0${week.week}'
                                    : 'Week ${week.week}',
                                style: TextStyle(
                                    fontSize: heading1 * 1.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: paddingSmall),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month_rounded,
                                    size: 14,
                                    color: disabledColor,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    "${week.startMonth} ${week.startDay}, ${week.startYear}",
                                    style: TextStyle(
                                      fontSize: heading1 * 0.65,
                                      color: disabledColor,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 14,
                                    color: disabledColor,
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.calendar_month_rounded,
                                    size: 14,
                                    color: disabledColor,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    "${week.endMonth} ${week.endDay}, ${week.endYear}",
                                    style: TextStyle(
                                      fontSize: heading1 * 0.65,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (context) => SchedulingPage(
                                        index: index,
                                        weekNumber: week.week!,
                                        startMonth: week.startMonth!,
                                        endMonth: week.endMonth!,
                                        startDay: week.startDay!,
                                        endDay: week.endDay!,
                                      ),
                                    ),
                                  )
                                  .then((value) => requestChange(0));
                            },
                            child: Icon(
                              Icons.edit_rounded,
                              size: 30,
                              color: primaryColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: paddingSmall),
                      Divider(
                        color: disabledColor,
                        thickness: 1.5,
                      ),
                      SizedBox(height: paddingSmall),
                      Text(
                        generateText(userName,week.days),
                        style: TextStyle(fontSize: heading2),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: paddingSmall)
            ],
          );
        });
  }
}
