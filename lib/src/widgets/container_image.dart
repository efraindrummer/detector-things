import 'package:flutter/material.dart';

class ContainerImage extends StatelessWidget {
  const ContainerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 350,
      child: Column(
        children: [
          Image.asset("assets/img/logo.png"),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}