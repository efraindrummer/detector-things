import 'package:flutter/material.dart';

class ContainerImage extends StatelessWidget {
  const ContainerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 450,
      child: Column(
        children: [
          Image.asset("assets/img/logo.png"),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}