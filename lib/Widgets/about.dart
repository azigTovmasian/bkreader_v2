import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import '../Data/about.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Pages/app_instruction.dart';
import 'about_buttons.dart';

class AboutW extends StatelessWidget {
  const AboutW({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //1
          Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                height: height * 0.62,
                width: width * 0.9,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 5, color: Color(0xfff7a521)),
                    bottom: BorderSide(width: 5, color: Color(0xff1c568a)),
                  ),
                  // 0xff71bfdc  light blue
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    //1
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: centerText(
                        text: AboutD.bkReader,
                        width: width,
                        height: height * 0.04,
                        color: Color(0xff1c568a),
                        textSize: height * 0.025,
                        textWeight: FontWeight.bold,
                      ),
                    ),
                    //2
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12,top: 12),
                      child: Container(
                        child: centerText(
                          width: width,
                          color: Color.fromARGB(255, 149, 163, 175),
                          text: AboutD.bkReaderBody,
                          textSize: height * 0.016,
                          height: height * 0.1,
                          textWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    //3
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AppInstructionP()),
                        );
                      },
                      child: centerText(
                        width: width,
                        color: Color(0xfff7a521),
                        text: AboutD.appUsage,
                        textSize: height * 0.02,
                        height: height * 0.05,
                        textWeight: FontWeight.w400,
                      ),
                    ),
                    //4
                    SizedBox(
                      width: width * 0.85,
                      child: Divider(
                        thickness: 3,
                        color: Color.fromARGB(255, 190, 189, 189),
                      ),
                    ),
                    //5
                    centerText(
                      text: AboutD.suponsored,
                      width: width,
                      height: height * 0.05,
                      color: Color(0xff1c568a),
                      textSize: height * 0.025,
                      textWeight: FontWeight.bold,
                    ),
                    //6
                    Container(
                      height: height * 0.065,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Capni.png'),
                            fit: BoxFit.fill),
                      ),
                      // child: SvgPicture.asset('assets/images/Capni.png'), // mn wchu lhad 2ln7s dletu sa3at adwr lysh ysir crush lma tafut lsf7t about
                    ),
                    //7
                    centerText(
                      text: AboutD.credits,
                      width: width,
                      height: height * 0.05,
                      color: Color(0xff1c568a),
                      textSize: height * 0.025,
                      textWeight: FontWeight.bold,
                    ),
                    //8
                    SizedBox(
                      height: 5,
                    ),
                    //9
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            //1
                            deepGrayText(
                              text: AboutD.jobTitle[0], //Architect
                              height: height,
                              width: width,
                            ),
                            //2
                            lightGrayText(
                              text: AboutD.names[0], // Akkad
                              height: height,
                              width: width,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            //3
                            deepGrayText(
                              text: AboutD.jobTitle[1], // Mob Dev.
                              height: height,
                              width: width,
                            ),
                            //4
                            lightGrayText(
                              text: AboutD.names[1], // Azig
                              height: height,
                              width: width,
                            ),
                            //5
                            lightGrayText(
                              text: AboutD.names[2], // Omar
                              height: height,
                              width: width,
                            ),
                            //6
                            lightGrayText(
                              text: AboutD.names[3], // Gaby
                              height: height,
                              width: width,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            //1
                            deepGrayText(
                              text: AboutD.jobTitle[2], // UI Designer
                              height: height,
                              width: width,
                            ),
                            //2
                            lightGrayText(
                              text: AboutD.names[4], // Samir
                              height: height,
                              width: width,
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //3
                            deepGrayText(
                              text: AboutD.jobTitle[4], // Graphic
                              height: height,
                              width: width,
                            ),
                            //5
                            lightGrayText(
                              text: AboutD.names[6], // Ornina
                              height: height,
                              width: width,
                            ),
                            SizedBox(
                              height: 7,
                            ),

                            //6
                            deepGrayText(
                              text: AboutD.jobTitle[5], // Concept
                              height: height,
                              width: width,
                            ),
                            //7
                            lightGrayText(
                              text: AboutD.names[7], // Jawad
                              height: height,
                              width: width,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          //2
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                height: height * 0.17,
                width: width * 0.9,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 5, color: Color(0xfff7a521)),
                    bottom: BorderSide(width: 5, color: Color(0xff1c568a)),
                  ),
                  // 0xff71bfdc  light blue
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    //1
                    centerText(
                      text: AboutD.followUs,
                      width: width,
                      height: height * 0.03,
                      color: Color(0xff1c568a),
                      textSize: height * 0.025,
                      textWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    //2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //1
                        InkWell(
                          onTap: () async {
                            await launchUrl(
                                Uri.parse('http://facebook.com/BetKanu'));
                          },
                          child: CircleAvatar(
                            radius: height * 0.05,
                            backgroundColor: Color.fromARGB(255, 177, 218, 252),
                            child: CircleAvatar(
                              radius: height * 0.047,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: height * 0.042,
                                child: Container(
                                  height: height * 0.15,
                                  width: width * 0.2,
                                  child: SvgPicture.asset(
                                    'assets/images/facebook.svg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //2
                        SizedBox(
                          child: InkWell(
                            onTap: () async {
                              await launchUrl(Uri.parse(
                                  'https://www.youtube.com/@BETKANU'));
                            },
                            child: CircleAvatar(
                              radius: height * 0.05,
                              backgroundColor:
                                  Color.fromARGB(255, 250, 179, 187),
                              child: CircleAvatar(
                                radius: height * 0.047,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: height * 0.042,
                                  child: Container(
                                    height: height * 0.15,
                                    width: width * 0.2,
                                    child: SvgPicture.asset(
                                      'assets/images/youtube.svg',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //3
                        SizedBox(
                          child: InkWell(
                            onTap: () async {
                              await launchUrl(Uri.parse(
                                  'https://www.betkanu.com/home/reader'));
                            },
                            child: CircleAvatar(
                              radius: height * 0.05,
                              backgroundColor:
                                  Color.fromARGB(255, 166, 229, 242),
                              child: CircleAvatar(
                                radius: height * 0.047,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: height * 0.042,
                                  child: Container(
                                    height: height * 0.15,
                                    width: width * 0.2,
                                    child: SvgPicture.asset(
                                      'assets/images/web.svg',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
       ),
          
       
          //3
          Padding(
            padding: const EdgeInsets.only(bottom: 7,top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //1
                ButtonWidget(
                  textSize: height * 0.018,
                  icon: Icons.arrow_back,
                  color: Colors.grey,
                  width: width * 0.25,
                  height: height * 0.06,
                  text: 'Back',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                //2
                ButtonWidget(
                  textSize: height * 0.018,
                  icon: Icons.share_rounded,
                  color: Color(0xfff7a521),
                  width: width * 0.26,
                  height: height * 0.06,
                  text: 'Share',
                  onPressed: () {
                    shareApp();
                  },
                ),
                //3
                ButtonWidget(
                  textSize: height * 0.018,
                  icon: Icons.thumb_up,
                  color: Color(0xff1c568a),
                  width: width * 0.25,
                  height: height * 0.06,
                  text: 'Rate',
                  onPressed: () {
                    rateApp();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
shareApp() {
  String message = 'BET KANU Reader App :\n' +
      'For Android : ' +
      'https://play.google.com/store/apps/details?id=com.BETKANU.BK_READER&hl=en&pli=1' +
      '\nFor iOS : ' +
      'https://apps.apple.com/tr/app/bet-kanu-reader/id1452612542';
  Share.share(message);
}

rateApp() {
  StoreRedirect.redirect(
    androidAppId: 'com.BETKANU.BK_READER',
    iOSAppId: '1452612542',
  );
}

Widget lightGrayText({
  required String text,
  required double height,
  required double width,
}) {
  return Text(
    text,
    style: TextStyle(
      color: Color.fromARGB(255, 139, 150, 160),
      fontSize: height * 0.018,
    ),
  );
}

Widget centerText(
    {required double width,
    required Color color,
    required String text,
    required double textSize,
    required double height,
    required FontWeight textWeight}) {
  return Container(
    height: height,
    width: width,
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

Widget deepGrayText({
  required String text,
  required double height,
  required double width,
}) {
  return Text(
    text,
    style: TextStyle(
      color: Color.fromARGB(255, 114, 123, 130),
      fontSize: height * 0.02,
      fontWeight: FontWeight.w800,
    ),
  );
}
