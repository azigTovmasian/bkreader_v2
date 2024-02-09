import 'package:flutter/material.dart';

class Utils {
  static void showTopSnackBar(
      BuildContext context, String message, Color color,Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
          content: Text(
        message,
        style: TextStyle(color: color,fontWeight: FontWeight.w500),
      ),
      duration: Duration(seconds: 3),),
    );
  }
}
