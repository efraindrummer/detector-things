
import 'package:detector_things/src/pages/detector/detector_page.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoWidth: 100,
      logo: Image.asset('assets/img/logo.png'),
      title: const Text(
        "Detector de Cosas",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: Text("Cargando..."),
      navigator: const DetectorPage(),
      durationInSeconds: 3,
    );
  }
}