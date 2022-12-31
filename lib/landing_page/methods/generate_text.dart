String generateText(String userName, var days) {
  /// For returning text
  String text = "";

  /// For checking whether the entire week is unavailable
  bool unavailableWeek = true;

  /// Temporary variable for storing available hours
  String availableHours = "";

  ///Temporary variable for counting available days.
  int dayCounter = 0;

  ///Temporary variable for counting available hours.
  int availableCounter = 0;

  /// Code for going through each day
  for (int i = days.length - 1; i >= 0; i--) {
    availableCounter = 0;

    /// Condition checks whether the day is available
    if (days[i].available) {
      String day = "";
      unavailableWeek = false;

      /// Switch for assigning day to text
      switch (i) {
        case 0:
          day = "Sunday";
          break;
        case 1:
          day = "Monday";
          break;
        case 2:
          day = "Tuesday";
          break;
        case 3:
          day = "Wednesday";
          break;
        case 4:
          day = "Thursday";
          break;
        case 5:
          day = "Friday";
          break;
        case 6:
          day = "Saturday";
          break;
      }

      /// Cases for adding values to availableHours based on available hours.
      if (days[i].hours.evening) {
        availableHours = 'evening';
        availableCounter++;
      }
      if (days[i].hours.afternoon) {
        if (availableCounter == 1) {
          availableHours = 'afternoon and $availableHours';
        } else if (availableCounter == 0) {
          availableHours = 'afternoon';
        }
        availableCounter++;
      }
      if (days[i].hours.morning) {
        if (availableCounter == 1) {
          availableHours = 'morning and $availableHours';
        } else {
          availableHours = 'morning';
        }
        availableCounter++;
      }

      /// Checks whether the entire day is free or not and assigns respective string to day variable.
      if (availableCounter == 3) {
        day = "the whole $day";
      } else {
        day = "$day $availableHours";
      }

      /// Switch for assigning day variable value and punctuations to text variable.
      switch (dayCounter) {
        case 0:
          text = '$day.';
          break;
        case 1:
          text = '$day and $text';
          break;
        default:
          text = '$day, $text';
          break;
      }
      dayCounter++;
    }
  }

  /// Checks weather the entire day is free or not.
  if (dayCounter == 7) {
    text = "Hi $userName, you are available for the whole week.";
  } else {
    text = 'Hi $userName, you are available on $text';
  }

  /// Checks weather the entire week is unavailable. If condition is true then variable text is re-assigned.
  if (unavailableWeek) {
    text = "Hi $userName, you are really busy this week.";
  }

  /// Return text
  return text;
}