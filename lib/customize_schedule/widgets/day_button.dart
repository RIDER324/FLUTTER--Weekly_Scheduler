import '../../constants/styles.dart';
import 'package:flutter/material.dart';

class DayButton extends StatelessWidget {
  const DayButton({
    Key? key,
    required this.onTap,
    required this.dayName,
    required this.isAvailable,
  }) : super(key: key);
  final String dayName;
  final bool isAvailable;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color colour = (isAvailable) ? successColor : disabledColor;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.check_circle_rounded,
            size: 20,
            color: colour,
          ),
          SizedBox(width: paddingMedium),
          Text(
            dayName,
            style: TextStyle(
              fontSize: heading1,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
