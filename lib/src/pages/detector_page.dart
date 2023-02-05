import 'dart:io';
import 'package:detector_things/src/widgets/detector_button.dart';
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

    final width = MediaQuery.of(context).size.width;

    final ImagePicker picker = ImagePicker();
    File _image;

    pickCameraImage() async {
      final image = await picker.pickImage(source: ImageSource.camera);
      if(image == null) return null;
      setState(() {
        _image = File(image.path);
      });
    }
    
    pickGalleryImage() async {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if(image == null) return null;
      setState(() {
        _image = File(image.path);
      });
    }

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
            ),

            SizedBox(height: 10),
            
            Container(
              width: width,
              child: Column(
                children: <Widget>[

                  DetectorButton(width: width - 100, title: "Tomar una Foto", onPressed: pickCameraImage),
                  SizedBox(height: 5),
                  DetectorButton(width: width - 100, title: "Abrir camara", onPressed: pickGalleryImage),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}