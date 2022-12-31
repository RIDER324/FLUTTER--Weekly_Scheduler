import '../../constants/styles.dart';
import 'package:flutter/material.dart';

class HourButton extends StatelessWidget {
  const HourButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);
  final String text;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color selectedColor = (isSelected) ? primaryColor : disabledColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(paddingSmall),
        decoration: BoxDecoration(
            border: Border.all(color: selectedColor, width: 1.5),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Text(
          text,
          style: TextStyle(fontSize: heading2),
        ),
      ),
    );
  }
}
