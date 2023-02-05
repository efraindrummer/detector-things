import 'package:flutter/material.dart';

class DetectorButton extends StatelessWidget {

  final double width;
  final String title;
  final void Function()? onPressed;

  const DetectorButton({
    super.key, 
    required this.width, 
    required this.title, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Text(
          title, 
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      )
    );
  }
}