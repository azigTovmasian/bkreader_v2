import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Images {
  static Widget image({
    required double height,
    required double width,
    required bool isSvg,
    required String bookImage,
  }) {
    return Container(
      height: height * 0.28,
      width: width * 0.69,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: isSvg
          ? svgImage(height: height, width: width, bookImage: bookImage)
          : notSvgImage(height: height, width: width, bookImage: bookImage),
    );
  }

  static Widget svgImage({
    required double height,
    required double width,
    required String bookImage,
  }) {
    return SvgPicture.network(
      bookImage,
      placeholderBuilder: (BuildContext context) => Center(
          child: CircularProgressIndicator(
        color: Color.fromARGB(255, 83, 158, 212),
      )),
      height: height * 0.28,
      width: width * 0.69,
    );
  }

  static Widget notSvgImage({
    required double height,
    required double width,
    required String bookImage,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Container(
          height: height * 0.2,
          width: width * 0.5,
          decoration: BoxDecoration(),
          child: Image.network(withoutlrln(bookImage: bookImage),
              fit: BoxFit.contain,
              errorBuilder: (context, exception, stacktrace) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/cooming_soon3.jpg'),
                ),
              ),
            );
          },
           loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          })),
    );
  }

  static String withoutlrln({
    required String bookImage,
  }) {
    late String imageURL;
    if (bookImage == '') {
      imageURL = 'https://www.shutterstock.com/search/network';
    } else {
      if (bookImage.contains("\r\n")) {
        imageURL = bookImage.substring(0, (bookImage.length) - 2);
      } else {
        imageURL = bookImage;
      }
    }
    return imageURL;
  }
}
