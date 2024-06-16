import 'package:flutter/material.dart';
import 'LandHomeScreen.dart';


void main()  {
 
  runApp(const MyApp());
}

//DATA
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Andika',
        primarySwatch: Colors.blue,
      ),
      home: const LandHomeScreen(),
    );
  }
}
