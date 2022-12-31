import '../widgets/use_dialog.dart';
import '../../constants/styles.dart';
import 'package:flutter/material.dart';
import '../../constants/shared_preference.dart';
import '../../landing_page/view/landing.page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String message = "";
  Color labelColor = Colors.black54;
  bool visibility = false, viewed = false;
  FocusNode focus1 = FocusNode(), focus2 = FocusNode();
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF4A00E0),
                primaryColor,
              ],
            )),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(paddingLarge * 2),
              child: Column(
                children: [
                  Flexible(flex: 1, child: Container()),
                  const Text(
                    'Hi!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Before you start,\nEnter your name below',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius)),
                    child: Focus(
                      onFocusChange: (value) {
                        setState(() {
                          labelColor =
                              (value) ? Colors.transparent : Colors.black54;
                        });
                      },
                      child: TextField(
                        controller: name,
                        keyboardType: TextInputType.text,
                        focusNode: focus1,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: labelColor),
                          contentPadding: EdgeInsets.all(paddingMedium),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1.5),
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.green, width: 1.5),
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibility,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red, fontSize: 10),
                      ),
                    ),
                  ),
                  SizedBox(height: paddingLarge),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        visibility = false;
                      });
                      if (name.text.isEmpty) {
                        setState(() {
                          message = "* Please enter a valid name";
                          visibility = true;
                        });
                      } else {
                        String data = name.text.trim();
                        bool success = await setSharedPreferencesName(data);
                        if (success && viewed) {
                          onTap();
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) =>
                                  const UseDialog()).then((value) {
                            viewed = true;
                            onTap();
                          });
                        }
                      }
                    },
                    focusNode: focus2,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black54),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius))),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "START",
                        style: TextStyle(
                            fontSize: heading1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(flex: 2, child: Container()),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) =>
                                    const UseDialog())
                            .then((value) => viewed = true);
                      },
                      child: const Icon(
                        Icons.info_outline_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onTap() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LandingPage(),
      ),
    );
  }
}
