import 'package:flutter/material.dart';

class Calender extends StatelessWidget {
  const Calender({
    Key? key,
    required this.day,
    required this.month,
  }) : super(key: key);
  final String day;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 0.65),
      children: [
        Icon(
          Icons.calendar_today_rounded,
          size: 48,
          color: Colors.grey.shade700,
        ),
        Column(
          children: [
            Text(
              month.toUpperCase(),
              style: const TextStyle(fontSize: 8),
              textAlign: TextAlign.center,
            ),
            Text(
              (day.length == 1) ? '0$day' : day,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}
