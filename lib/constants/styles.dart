import 'package:flutter/material.dart';

/// Colour values
Color primaryColor = const Color(0xFF8E2DE2);
Color secondaryColor = Colors.grey.shade800;
Color successColor = Colors.green;
Color disabledColor = Colors.grey.shade500;
Color backgroundColour = Colors.grey.shade300;

/// Widget attribute values
double paddingSmall = 4;
double paddingMedium = 8;
double paddingLarge = 12;
double borderRadius = 10;
double heading1 = 16;
double heading2 = 14;

/// Storage Value
List newDays = [
  {
    "day": "SUN",
    "available": true,
    "hours": {"morning": true, "afternoon": true, "evening": true}
  },
  {
    "day": "MON",
    "available": true,
    "hours": {"morning": true, "afternoon": true, "evening": true}
  },
  {
    "day": "TUE",
    "available": true,
    "hours": {"morning": true, "afternoon": true, "evening": true}
  },
  {
    "day": "WED",
    "available": true,
    "hours": {"morning": true, "afternoon": true, "evening": true}
  },
  {
    "day": "THU",
    "available": true,
    "hours": {"morning": true, "afternoon": true, "evening": true}
  },
  {
    "day": "FRI",
    "available": true,
    "hours": {"morning": true, "afternoon": true, "evening": true}
  },
  {
    "day": "SAT",
    "available": true,
    "hours": {"morning": true, "afternoon": true, "evening": true}
  }
];
String howToUse = """
STARTUP PAGE:
\nThis is the current page where you are reading this information. If you don't enter your name, please do enter after reading this startup guide, else you are good for continuing.
The current page will be available once you set up your name and your name or information will not be collected or shared with any other entities. To close this pop-up, press the cross button on the top left corner.
\nLANDING PAGE:
\nIt is the page where you will be seeing the four-week schedule. After each week passes, the respective schedule will be removed automatically. The following are the features and functions of this page.
        1. With the help of a floating ADD button, you can add or update a new weekly schedule. Moreover, you will be provided with a day picker starting from four weeks after the current week and selecting one day from the week will automatically select an entire week.
        2. After creating a new week's schedule, or if you want to edit your existing weekly schedule, you can press the edit button present in the top left corner of each week's card, which will then take you to the SCHEDULING PAGE.
        3. This page is capable of showing the entire week's schedule availability at once. The entire week's schedule summary is provided beneath the week number.
\nSCHEDULING PAGE:  
\nIt is the final page where you will be able to edit the entire schedule of the week. The following are the features and functions of this page.
        1. You can select or unselect any of the available hours of a day. In case you are not available an entire day, pressing the check mark on the left side of the day's name will make the entire day unavailable and vice-versa.
        2. The save button at the end will save your entire schedule to a local database.
        3. The back button on the application bar will move you to the LANDING PAGE without saving your work. So, if you want to save the schedule data, please press the 'SAVE' button and then proceed with the back button.""";

