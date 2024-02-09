import 'package:flutter/material.dart';

class IntroLogo extends StatefulWidget {
  const IntroLogo({super.key});

  @override
  State<IntroLogo> createState() => _IntroLogoState();
}

class _IntroLogoState extends State<IntroLogo> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
            top: height * 0.08,
            left: width * 0.08,
            right:  width * 0.08,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                height: height * 0.49,
                width: width * 0.7,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 5, color: Color(0xfff7a521)),
                    bottom: BorderSide(width: 5, color: Color(0xff1c568a)),
                  ),
                  color: Colors.white,
                ),
              ),
            )),
            Positioned(
        top: height * 0.17,
        left: width * 0.23,
        right:  width * 0.23,
        child: Container(
          height: height * 0.3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/BK_Reader_logo.png'),
                  fit: BoxFit.fill)),
        ),
      ),
      Positioned(
        top: height * 0.59,
        left: width * 0.1,
        right: width * 0.1,
        child: Text(
          textAlign: TextAlign.center,
          ' ܩܪܘܢܬܐ ܕܒܢܬ ܥܐܢܘ \n ܬܘܠܚܡܐ ܡܥܕܪܢܐ ܠܝܘܠܦܢܐ ܕܠܫܢܐ',
          style: TextStyle(
              color: Color(0xff1c568a),
              fontWeight: FontWeight.bold,
              fontSize: height * 0.018),
        ),
      ),
      ],
    );
  }
}
