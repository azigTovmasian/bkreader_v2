import 'package:bk_reader_v2/Widgets/zoomable_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../Providers/home.dart';
import 'images.dart';
import 'internal_video.dart';

class BookPages extends StatefulWidget {
  const BookPages({super.key});

  @override
  State<BookPages> createState() => _BookPagesState();
}

class _BookPagesState extends State<BookPages> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final book = Provider.of<HomeProv>(context, listen: true).book();
    final homeProv = Provider.of<HomeProv>(context, listen: true);
    final isSvg = Provider.of<HomeProv>(context, listen: true).isSvg();
    final isInternalVideo =
        Provider.of<HomeProv>(context, listen: true).isInternalVideo();

    return Stack(
      children: [
        Positioned(
          top: height * 0.1,
          bottom: height * 0.35,
          left: width * 0.08,
          right: width * 0.08,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: width * 0.85,
              height: height * 0.6,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 5, color: Color(0xfff7a521)),
                  bottom: BorderSide(width: 5, color: Color(0xff1c568a)),
                ),
                color: Colors.white,
              ),
              child:!homeProv.isBetkanuProduct()?Center(child: SizedBox(width: width*0.7,child: Text("The QR Code you've scanned is not a BETKANU Product",textAlign: TextAlign.center,))): Column(
                children: [
                  SizedBox(height: height * 0.01),
                  Container(
                    height: height * 0.25,
                    child: !homeProv.isSuccess()
                        ? Center(
                            child: Icon(
                              Icons.error_outline_rounded,
                              size: 100,
                              color: Color(0xfff7a521),
                            ),
                          )
                        : isInternalVideo?VideoPlayerWidget(book["VideoURL"]): ZommableImage(
                                imageWidget: Images.image(
                                  height: height,
                                  width: width,
                                  isSvg: isSvg,
                                  bookImage: book["ImageURL"],
                                ),
                              ),
                  ),
                  SizedBox(
                    width: width*0.75,
                    child: Divider(
                      thickness: 2,
                      color: (Provider.of<HomeProv>(context, listen: true)
                                  .isImageZoomed()) ||
                              !homeProv.isSuccess()
                          ? Colors.transparent
                          : Color.fromARGB(255, 139, 150, 160),
                    ),
                  ),
                  homeProv.isSuccess()
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.79,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Scrollbar(
                              scrollbarOrientation: ScrollbarOrientation.left,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(right: width * 0.04),
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Container(
                                      width: width * 0.7,
                                      child: Text(
                                        (Provider.of<HomeProv>(context,
                                                    listen: true)
                                                .isImageZoomed())
                                            ? ""
                                            : "${Provider.of<HomeProv>(context).bookTextS()}",
                                        style: TextStyle(
                                          fontSize: height * width * 0.000055,
                                          color: Color(0xff1c568a),
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: book["TextLanguage"]
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'western'
                                              ? 'WesternSyriac'
                                              :book["TextLanguage"]
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'eastern'? 'EasternSyriac':'ClassicSyriac',
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                    Visibility(
                                      visible: !Provider.of<HomeProv>(context)
                                              .isOnlySyriac() &&
                                          homeProv.isSuccess(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Container(
                                          width: width * 0.7,
                                          color: Colors.transparent,
                                          child: Text(
                                            Provider.of<HomeProv>(context)
                                                .bookTextG(),
                                            style: TextStyle(
                                              color: Color(0xff1c568a),
                                            ),
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            width: width,
                            child: Text(
                              'Something went wrong! \nPlease try again later.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


Widget createVideoWidget(String mp4Url) {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  _controller = VideoPlayerController.networkUrl(Uri.parse(mp4Url));
  _initializeVideoPlayerFuture = _controller.initialize().then((_) {
    _controller.play();
  });

  return FutureBuilder(
    future: _initializeVideoPlayerFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        );
      } else {
        return Center(
          child: Container(),
        );
      }
    },
  );
}
