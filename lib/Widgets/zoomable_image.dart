import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/home.dart';

class ZommableImage extends StatefulWidget {
  final Widget imageWidget;
  const ZommableImage({super.key, required this.imageWidget});

  @override
  State<ZommableImage> createState() => _ZommableImageState();
}

class _ZommableImageState extends State<ZommableImage>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  TapDownDetails? tapDownDetails;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  OverlayEntry? entry;
  double scale = 1;
  final double minScale = 1;
  final double maxScale = 4;

  @override
  void initState() {
    super.initState();

    controller = TransformationController();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            controller.value = animation!.value;
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              removeOverlay();
            }
          });
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildImage();
  }

  void showOverlay(
    BuildContext context,
  ) {
    final width = MediaQuery.of(context).size.width;

    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
      builder: (context) {
        final double opacity = ((scale - 1) / (maxScale - 1)).clamp(0, 1);
        return Stack(
          children: [
            Positioned.fill(
                child: Opacity(
              opacity: opacity,
              child: Container(
                color: Colors.black,
              ),
            )),
            Positioned(
                top: offset.dy,
                left: offset.dx,
                width: width,
                child: 
                buildImage()),
          ],
        );
      },
    );
    final overlay = Overlay.of(context);
    overlay.insert(entry!);
  }

  Widget buildImage() {
    return Builder(builder: (context) {
      return InteractiveViewer(
              transformationController: controller,
              clipBehavior: Clip.none,
              minScale: minScale,
              maxScale: maxScale,
              onInteractionStart: (details) {
                if (details.pointerCount < 2) return;
                showOverlay(context);
                Provider.of<HomeProv>(context,listen: false).setIsImageZoomed(true);
              },
              onInteractionUpdate: (details) {
                if (entry == null) return;
                this.scale = details.scale;
                entry!.markNeedsBuild();
              },
              onInteractionEnd: (details) {
                resetAnimation();
                Provider.of<HomeProv>(context,listen: false).setIsImageZoomed(false);
              },
              child: AspectRatio(
                aspectRatio: 2,
                child: widget.imageWidget,
              )
              );
    });
  }

  void resetAnimation() {
    animation = Matrix4Tween(begin: controller.value, end: Matrix4.identity())
        .animate(CurvedAnimation(parent: animationController, curve: Curves.elasticOut));
    animationController.forward(from: 0);
  }

  void removeOverlay() {
    entry?.remove();
    entry = null;
  }
}
