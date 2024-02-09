import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double textSize;

  const ButtonWidget({
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.textSize,
    this.height = 40.0,
    this.width = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: textSize,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: color,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
