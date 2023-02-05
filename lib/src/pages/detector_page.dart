import 'dart:io';
import 'package:detector_things/src/widgets/container_image.dart';
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

  final picker = ImagePicker();
  late File _image;
  bool _loading = false;
  List _output = [];

  pickImage() async {
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  pickGalleryImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      //setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {

    final output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5
    );

    setState(() {
      _loading = false;
      _output = output!;
    });
  }

  Future loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
        
              const SizedBox(height: 50),
              const Text("Tauchable Machine CNN"),
              const SizedBox(height: 6),
              const Text("Detector Things"),
              const SizedBox(height: 20),
              
              Center(
                child: _loading ? const ContainerImage() : Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: Image.file(_image),
                    ),
                    const SizedBox(height: 20),
                    // ignore: unnecessary_null_comparison
                    _output != null 
                    ? 
                    Text(
                      '${_output[0]['label']}', 
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28
                      )
                    )
                    : Container()
                  ],
                ),
              ),
        
              Container(
                width: width,
                child: Column(
                  children: <Widget>[
        
                    DetectorButton(width: width - 100, title: "Tomar una Foto", onPressed: pickImage),
                    const SizedBox(height: 5),
                    DetectorButton(width: width - 100, title: "Abrir camara", onPressed: pickGalleryImage),
        
                  ],
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}