import 'package:bk_reader_v2/Widgets/scanned_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../Pages/about.dart';
import '../Providers/home.dart';
import 'package:provider/provider.dart';
import 'intro_logo.dart';

class HomeBodyW extends StatefulWidget {
  const HomeBodyW({super.key});
  @override
  State<HomeBodyW> createState() => _HomeBodyWState();
}

class _HomeBodyWState extends State<HomeBodyW> {
  String qrCode = '';
  final audioPlayer = AudioPlayer();
  final assetPlayer = AudioPlayer();
  bool isPlaying = false;
  HomeProv? homeProv; // Save a reference to the ancestor widget
  bool audioCompleted = false; // Flag to track audio completion

  @override
  void initState() {
    super.initState();

    audioPlayer.playerStateStream.listen((PlayerState state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
          audioCompleted = true; // Set the flag to true on audio completion
        });
      } else if (state.playing) {
        setState(() {
          isPlaying = true;
          audioCompleted = false; // Reset the flag when audio starts playing
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeProv = Provider.of<HomeProv>(context, listen: false);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    assetPlayer.dispose();
    homeProv = null;
    super.dispose();
  }

  void playAudio(String url) {
    setState(() {
      isPlaying = true;
    });
    audioPlayer.setUrl(url);
    audioPlayer.play();
  }

  void togglePlayPause(String url) {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.setUrl(url);
      audioPlayer.play();
    }
    // setState(() {
    //   isPlaying = !isPlaying;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isScanned = Provider.of<HomeProv>(context).isScanned();
    bool isLoaded = Provider.of<HomeProv>(context, listen: true).isLoaded();

    final homeProv = Provider.of<HomeProv>(context);
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
      ),
      Visibility(
        visible: !isScanned || homeProv.isYoytube(),
        child: IntroLogo(),
        replacement: isLoaded
            ? BookPages()
            : Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 83, 158, 212),
                ),
              ),
      ),
      Positioned(
          bottom: 0,
          child: Container(
            height: height * 0.07,
            width: width,
            child: SvgPicture.asset(
              'assets/images/bottom_bar.svg',
              color: Colors.white,
              fit: BoxFit.fill,
            ),
          )),
      Positioned(
          bottom: height * 0.06,
          right: width * 0.14,
          child: InkWell(
            onTap: () async {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SafeArea(
                    child: Stack(
                      children: [
                        MobileScanner(
                          allowDuplicates: false,
                          controller: MobileScannerController(
                            facing: CameraFacing.back,
                          ),
                          onDetect: (qrCode, args) async {
                            homeProv.setIsSuccess(false);
                            homeProv.setIsLoaded(false);
                            homeProv.setIsInternalVideo(false);
                            homeProv.clearBook();
                            homeProv.clearVideoUrl();
                            homeProv.setIsScanned(true);
                            homeProv.setQRCodeValue(qrCode.rawValue!);
                            assetPlayer.setAudioSource(
                                AudioSource.asset('assets/audios/scan.mp3'));
                            assetPlayer.play();

                            await homeProv.QRCodeURL(context);
                            if (homeProv.isSuccess() &&
                                !homeProv.isYoytube() &&
                                (homeProv
                                        .getElementFromBook("AudioURL")
                                        .toLowerCase() !=
                                    "null")) {
                              playAudio(
                                  homeProv.getElementFromBook("AudioURL"));
                            }
                            Navigator.pop(context);
                          },
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: height * 0.7,
                          child: Container(
                            height: height * 0.2,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.4,
                          bottom: height * 0.4,
                          child: Center(
                            child: Container(
                              height: 3,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.7,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: height * 0.2,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
            },
            child: CircleAvatar(
              radius: height * 0.064,
              backgroundColor: Color.fromARGB(255, 173, 203, 228),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: height * 0.06,
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: height * 0.085,
                  color: Color(0xff1c568a),
                ),
              ),
            ),
          )),
      Positioned(
          bottom: height * 0.06,
          left: width * 0.14,
          child: InkWell(
            onTap: homeProv.isSuccess()
                ? () {
                    togglePlayPause(homeProv.getElementFromBook("AudioURL"));
                  }
                : null,
            child: CircleAvatar(
              radius: height * 0.064,
              backgroundColor: homeProv.isSuccess()
                  ? Color.fromARGB(255, 240, 228, 208)
                  : Color.fromARGB(255, 226, 224, 222),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: height * 0.06,
                child: Icon(
                  audioCompleted ? Icons.play_arrow_rounded:isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                  size: height * 0.12,
                  color: homeProv.isSuccess()
                      ? Color(0xfff7a521)
                      : Color.fromARGB(255, 176, 147, 119),
                ),
              ),
            ),
          )),
      Positioned(
          bottom: height * 0.005,
          left: width * 0.3,
          right: width * 0.3,
          child: InkWell(
              onTap: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AboutP()));
              },
              child: Icon(
                Icons.info_outline_rounded,
                size: height * 0.06,
                color: Color.fromARGB(255, 207, 206, 206),
              ))),
    ]);
  }
}
