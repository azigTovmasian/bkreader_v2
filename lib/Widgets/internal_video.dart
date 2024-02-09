import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget(this.videoUrl);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleVideoPlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isVideoPlaying = false;
      } else {
        _controller.play();
        _isVideoPlaying = true;
      }
    });
  }

  Widget _buildPlayPauseButton() {
    return IconButton(
      icon: Icon(
        _isVideoPlaying ? Icons.pause : Icons.play_arrow_rounded,
        color: Colors.white,
        size: 40,
      ),
      onPressed: _toggleVideoPlayback,
    );
  }

Widget _buildVideoProgressBar() {
  return SliderTheme(
    data: SliderThemeData(
      trackHeight: 2.0,
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: 6.0,
      ),
      overlayShape: RoundSliderOverlayShape(
        overlayRadius: 6.0,
      ),
    ),
    child: Slider(
      value: _controller.value.position.inMilliseconds.toDouble(),
      min: 0,
      max: _controller.value.duration.inMilliseconds.toDouble(),
      onChanged: (value) {
        setState(() {
          _controller.seekTo(Duration(milliseconds: value.toInt()));
        });
      },
    ),
  );
}
Widget _buildVideoControls(double width) {
  return Positioned(
    bottom: 8,
    left: 5,
    right: 5,
    child: Container(
      width: width,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlayPauseButton(),
          _buildVideoProgressBar(),
        ],
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return VideoPlayer(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        _buildVideoControls(width),
      ],
    );
  }
}
