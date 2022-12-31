import '../widgets/week_cards.dart';
import '../../constants/styles.dart';
import '../methods/date_methods.dart';
import 'package:flutter/material.dart';
import '../methods/sorting_methods.dart';
import '../../constants/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef CallBack = void Function(int value);

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _data;
  String userName = "";

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    _data = _prefs.then((SharedPreferences prefs) async {
      if (!prefs.containsKey('list')) {
        await getSharedPreferencesData();
      }
      userName = await getSharedPreferencesName();
      return prefs.getString('list') ?? "";
    });
  }

  Future<void> addData(String data) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _data = prefs.setString('list', data).then((bool success) {
        return data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(
        title: const Text(
          "Welcome",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return WeekCards(
                  userName: userName,
                  jsonData: snapshot.data!,
                  requestChange: (int value) => setState(() {
                    getData();
                  }),
                );
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /// TODO: If you want to clear SharedPreferences data.
          ///clearSharedPreferences();
          DateTime initialDate = getLastDate();
          DateTime lastDate = DateTime(initialDate.year + 1);
          DateTime? pickDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: initialDate,
            lastDate: lastDate,
            helpText: "CHOOSE A DATE OF A WEEK",
          );

          ///Code for generating data for a new week and adding it to shared preferences
          if (pickDate != null) {
            List list = getWeekInformation(pickDate, pickDate.weekday);
            String finalData = await returnNewData(list[0], list[1]);
            addData(finalData);
          }
        },
        child: const Icon(Icons.add_rounded, size: 30),
      ),
    );
  }
}
