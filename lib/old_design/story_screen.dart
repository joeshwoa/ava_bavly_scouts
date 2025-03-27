/*
import '../utils/utils_stub.dart' if (dart.library.html) 'web_utils.dart' if (dart.library.io) 'non_web_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  final String mediaUrl; // URL of the media from Supabase storage
  final bool isVideo; // Whether the media is video or image

  const StoryScreen({required this.mediaUrl, required this.isVideo, super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late VideoPlayerController _videoController;
  bool _downloading = false;
  double _progress = 0.0; // Added to track download progress

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _initializeVideoPlayer();
    }
  }

  Future<void> _initializeVideoPlayer() async {
    _videoController = VideoPlayerController.network(widget.mediaUrl)
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
        _videoController.setLooping(true);
      });
  }

  void _downloadMedia() {
    if (kIsWeb) {
      downloadFile(
        context,
        startFun: () {
          setState(() {
            _downloading = true;
            _progress = 0.0; // Reset progress before starting download
          });
        },
        isVideo: widget.isVideo,
        mediaUrl: widget.mediaUrl,
        endFun: () {
          setState(() {
            _downloading = false;
          });
        },
        progressFun: (received, total) {
          if (total != -1) {
            // Update download progress
            setState(() {
              _progress = received / total;
            });
          }
        }
      );
    } else {
      downloadFile(
          context,
          startFun: () {
            setState(() {
              _downloading = true;
              _progress = 0.0; // Reset progress before starting download
            });
          },
          isVideo: widget.isVideo,
          mediaUrl: widget.mediaUrl,
          endFun: () {
            setState(() {
              _downloading = false;
            });
          },
          progressFun: (received, total) {
            if (total != -1) {
              // Update download progress
              setState(() {
                _progress = received / total;
              });
            }
          }
      );
    }
  }

  @override
  void dispose() {
    if (widget.isVideo) {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(kIsWeb) {
      // Define MetaSEO object
      MetaSEO meta = MetaSEO();
      // add meta seo data for web app as you want
      meta.author(author: 'Eng Joeshwoa George');
      meta.description(description: 'AVA Bavly Beginners Scouts Site');
      meta.keywords(keywords: 'AVA Bavly Beginners Scouts, Scouts, Beginners Scouts, AVA Bavly, AVA Bavly Scouts');
      meta.ogTitle(ogTitle: 'AVA Bavly Beginners Scouts');
      meta.ogDescription(ogDescription: 'AVA Bavly Beginners Scouts');
    }
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: _downloading ? null : _downloadMedia,
        backgroundColor: const Color(0xff405DE6),
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedDownloadSquare02,
          color: Colors.white,
          size: 30,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowTurnBackward,
            color: Colors.white,
            size: 24.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: widget.isVideo
                ? _videoController.value.isInitialized
                ? AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            )
                : const CircularProgressIndicator()
                : Image.network(
              widget.mediaUrl,
              fit: BoxFit.contain,
            ),
          ),
          if (_downloading)
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff405DE6).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xff405DE6),
                    width: 2
                  )
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      value: _progress, // Show progress in the indicator
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${(_progress * 100).toStringAsFixed(0)}%', // Display percentage
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
*/
