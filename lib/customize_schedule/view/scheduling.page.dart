import '../widgets/calender.dart';
import '../../constants/styles.dart';
import 'package:flutter/material.dart';
import '../widgets/scheduling_list.dart';

class SchedulingPage extends StatelessWidget {
  const SchedulingPage({
    Key? key,
    required this.index,
    required this.weekNumber,
    required this.startMonth,
    required this.endMonth,
    required this.startDay,
    required this.endDay,
  }) : super(key: key);
  final int index;
  final int weekNumber;
  final String startMonth;
  final String endMonth;
  final int startDay;
  final int endDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: ()=> Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
          ),
        ),
        title: Text((weekNumber<10)?'Week 0$weekNumber':'Week $weekNumber'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(paddingMedium),
        child: Column(
          children: [
            SizedBox(height: paddingSmall),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: paddingSmall),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Your schedule for week: ',
                            style: TextStyle(fontSize: heading1),
                          ),
                          Text(
                              (weekNumber<10)?'0$weekNumber':weekNumber.toString(),
                            style: TextStyle(
                              fontSize: heading1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Set your weekly hours',
                        style: TextStyle(
                          fontSize: heading1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Calender(
                    day: startDay.toString(),
                    month: startMonth,
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                  ),
                  Calender(
                    day: endDay.toString(),
                    month: endMonth,
                  ),
                ],
              ),
            ),
            SizedBox(height: paddingMedium),
            SchedulingList(index: index),
          ],
        ),
      ),
    );
  }
}
