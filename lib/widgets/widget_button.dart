import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.textColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, 
      ), child: Text(
        text,
        style: TextStyle(color: textColor),
        ),
    );
  }
}