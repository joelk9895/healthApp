import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideosPage extends StatelessWidget {
  final List<String> videoPaths = [
    'assets/video1.mp4',
    'assets/video2.mp4',
    'assets/video3.mp4',
    'assets/video4.mp4',
    'assets/video5.mp4',
  ];

  final List<String> thumbnailPaths = [
    'assets/image1.png',
    'assets/image1.png',
    'assets/image1.png',
    'assets/image1.png',
    'assets/image1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Videos',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              )),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: videoPaths.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoPlayerPage(
                          videoPath: videoPaths[index],
                        ),
                      ),
                    );
                  },
                  child: VideoThumbnail(
                    videoPath: videoPaths[index],
                    thumbnailPath: thumbnailPaths[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class VideoThumbnail extends StatefulWidget {
  final String videoPath;
  final String thumbnailPath;

  const VideoThumbnail({
    Key? key,
    required this.videoPath,
    required this.thumbnailPath,
  }) : super(key: key);

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath);
    _controller.initialize().then((_) {
      setState(() {}); // Update the state once video is initialized
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width /
                    _controller.value.aspectRatio,
                child: Image.asset(
                  widget.thumbnailPath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : Container(); // Placeholder for uninitialized video
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoPath;

  const VideoPlayerPage({Key? key, required this.videoPath}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    final videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: videoPlayerController.value.aspectRatio,
      // Add other customization options as needed
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video')),
      body: Center(
        child: Chewie(controller: _chewieController),
      ),
    );
  }
}
