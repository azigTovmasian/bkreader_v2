import 'package:flutter/material.dart';
import 'package:bk_reader_v2/Widgets/about_buttons.dart';

class AppInstructionP extends StatelessWidget {
  const AppInstructionP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.08),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                height: height * 0.5,
                width: width * 0.9,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 5, color: Color(0xfff7a521)),
                    bottom: BorderSide(width: 5, color: Color(0xff1c568a)),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    centerText(
                      color: Color(0xff1c568a),
                      text: 'App Instructions',
                      textSize: 24,
                      textWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    centerText(
                      color: Colors.grey,
                      text: 'Step 1:',
                      textSize: 18,
                      textWeight: FontWeight.normal,
                    ),
                    centerText(
                      color: Color(0xfff7a521),
                      text: 'Go to BET KANU READER page',
                      textSize: 14,
                      textWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    centerText(
                      color: Colors.grey,
                      text: 'Step 2:',
                      textSize: 18,
                      textWeight: FontWeight.normal,
                    ),
                    centerText(
                      color: Color(0xfff7a521),
                      text: 'Download the book you like to scan and read',
                      textSize: 14,
                      textWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    centerText(
                      color: Colors.grey,
                      text: 'Step 3:',
                      textSize: 18,
                      textWeight: FontWeight.normal,
                    ),
                    centerText(
                      color: Color(0xfff7a521),
                      text: 'Print out the PDF book you downloaded',
                      textSize: 14,
                      textWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    centerText(
                      color: Colors.grey,
                      text: 'Step 4:',
                      textSize: 18,
                      textWeight: FontWeight.normal,
                    ),
                    centerText(
                      color: Color(0xfff7a521),
                      text: 'Use the App to scan the codes',
                      textSize: 14,
                      textWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            ButtonWidget(
              height: height*0.05,
              textSize: height*0.02,
              width: width*0.9,
              icon: Icons.arrow_back,
              text: 'Back',
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget centerText({
  required Color color,
  required String text,
  required double textSize,
  required FontWeight textWeight,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: textSize,
          fontWeight: textWeight,
        ),
      ),
    ),
  );
}
