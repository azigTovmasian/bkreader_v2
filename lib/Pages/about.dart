import 'package:flutter/material.dart';
import '../Widgets/about.dart';


class AboutP extends StatelessWidget {
  const AboutP({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body:AboutW(),
      ),
    );
  }
}
