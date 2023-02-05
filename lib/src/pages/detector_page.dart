import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetectorPage extends StatefulWidget {
  const DetectorPage({super.key});

  @override
  State<DetectorPage> createState() => _DetectorPageState();
}

class _DetectorPageState extends State<DetectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 50),
            Text("Tauchable Machine CNN"),
            SizedBox(height: 6),
            Text("Detector Things"),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 300,
                child: Column(
                  children: [
                    Image.asset("assets/img/logo.png")
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}