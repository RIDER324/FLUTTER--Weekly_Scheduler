import '../../constants/styles.dart';
import 'package:flutter/material.dart';

class UseDialog extends StatelessWidget {
  const UseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: width,
          height: height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 75,
                padding: EdgeInsets.all(paddingLarge * 1.5),
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "HOW TO USE",
                      style: TextStyle(
                          color: Colors.white,
                          //fontSize: heading3,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        //size: heading2,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: height * 0.8 - 75,
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(paddingLarge * 1.5),
                      child: Text(
                        howToUse,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.black),
                        maxLines: 300,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
