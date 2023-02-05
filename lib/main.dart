import 'package:detector_things/src/pages/detector_page.dart';
import 'package:detector_things/src/pages/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detector Things',
      initialRoute: 'splashscreen',
      routes: {
        'detector' : (BuildContext context) => const DetectorPage(),
        'splashscreen' : (BuildContext context) => const Splashscreen()
      },
    );
  }
}