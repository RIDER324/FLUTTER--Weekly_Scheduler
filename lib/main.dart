import 'constants/styles.dart';
import 'package:flutter/material.dart';
import 'start_page/views/start.page.dart';
import 'constants/shared_preference.dart';
import 'landing_page/view/landing.page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> checkUser() async {
    bool newUser = await checkSharedPreferencesName();
    return newUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        fontFamily: 'Poppins',
      ),
      home: FutureBuilder<bool>(
          future: checkUser(),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return (snapshot.data!) ? const LandingPage() : const StartPage();
                }
            }
          }),
    );
  }
}
