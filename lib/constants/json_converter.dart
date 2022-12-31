/// Example Usage
/// Map<String, dynamic> map = jsonDecode(<myJSONString>);
/// var myRootNode = Root.fromJson(map);

class Root {
  int? week;
  int? startYear;
  int? endYear;
  String? startMonth;
  String? endMonth;
  int? startDay;
  int? endDay;
  List<Day?>? days;

  Root({
    this.week,
    this.startYear,
    this.endYear,
    this.startMonth,
    this.endMonth,
    this.startDay,
    this.endDay,
    this.days,
  });

  Root.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    startYear = json['startYear'];
    endYear = json['endYear'];
    startMonth = json['startMonth'];
    endMonth = json['endMonth'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    if (json['days'] != null) {
      days = <Day>[];
      json['days'].forEach((v) {
        days!.add(Day.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['week'] = week;
    data['startYear'] = startYear;
    data['endYear'] = endYear;
    data['startMonth'] = startMonth;
    data['endMonth'] = endMonth;
    data['startDay'] = startDay;
    data['endDay'] = endDay;
    data['days'] = days != null ? days!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class Day {
  String? day;
  bool? available;
  Hours? hours;

  Day({
    this.day,
    this.available,
    this.hours,
  });

  Day.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    available = json['available'];
    hours = json['hours'] != null ? Hours?.fromJson(json['hours']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['available'] = available;
    data['hours'] = hours!.toJson();
    return data;
  }
}

class Hours {
  bool? morning;
  bool? afternoon;
  bool? evening;

  Hours({
    this.morning,
    this.afternoon,
    this.evening,
  });

  Hours.fromJson(Map<String, dynamic> json) {
    morning = json['morning'];
    afternoon = json['afternoon'];
    evening = json['evening'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['morning'] = morning;
    data['afternoon'] = afternoon;
    data['evening'] = evening;
    return data;
  }
}
