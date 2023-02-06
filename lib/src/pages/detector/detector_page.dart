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
  List? _output;

  pickImageCamera() async {
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
      setState(() {});
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
      numResults: 19,
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Esto es lo que puede detectar"),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Text(
                'Esta app tiene un modelo entrenado y listo para detectar por Camara o Galeria las siguientes cosas que estas listadas', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),

            ListTile(title: Text("DOG")),
            ListTile(title: Text("CAT")),
            ListTile(title: Text("BIRD")),
            ListTile(title: Text("WATER CLEAN")),
            ListTile(title: Text("DIRTY WATER")),
            ListTile(title: Text("WATER BOTTLE")),
            ListTile(title: Text("PERSON WITH MASK")),
            ListTile(title: Text("PERSON WITHOUT MASK")),
            ListTile(title: Text("LAPTOP")),
            ListTile(title: Text("BACKPACK")),
            ListTile(title: Text("PEN")),
            ListTile(title: Text("KEYBOARD")),
            ListTile(title: Text("FILE CABINET")),
            ListTile(title: Text("DESK LAMP")),
            ListTile(title: Text("MONITOR")),
            ListTile(title: Text("PAPER NOTEBOOK")),
            ListTile(title: Text("MUG")),
            ListTile(title: Text("PROJECTOR")),
            ListTile(title: Text("PRINTER")),
            ListTile(title: Text("DESKTOP CHAIR")),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
        
              const SizedBox(height: 30),
              const Text("Detector de 20 cosas"),
              const SizedBox(height: 6),
              const Text("Efrain May"),
              const SizedBox(height: 20),
              
              Center(
                child: _loading ? const ContainerImage() : Column(
                  children: <Widget>[
                    SizedBox(height: 450, child: Image.file(_image)),
                    const SizedBox(height: 20),
                    _output != null 
                    ? Text(
                      'ESTO ES UN: ${_output![0]['label']}', 
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                    )
                    : Container()
                  ],
                ),
              ),
        
              SizedBox(
                width: width,
                child: Column(
                  children: <Widget>[
        
                    DetectorButton(width: width - 100, title: "Desde Camara", onPressed: pickImageCamera),
                    DetectorButton(width: width - 100, title: "Desde Galeria", onPressed: pickGalleryImage),
        
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