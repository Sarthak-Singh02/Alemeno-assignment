import 'package:alemeno/LandClickPicture.dart';
import 'package:flutter/material.dart';

class LandHomeScreen extends StatelessWidget {
  const LandHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 150),
          child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(15),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff3e8b3a)),
                  fixedSize: MaterialStateProperty.all(const Size(229, 56)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
              onPressed: () {
                Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) =>  LandClickPicture (),
    ),
  );
              },
              child: const Text(
                "Share your meal",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              )),
        ),
      ),
    );
  }
}
