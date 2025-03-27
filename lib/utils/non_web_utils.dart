/*
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadFile(BuildContext context, {required Function() startFun, required bool isVideo, required String mediaUrl, required Function(int, int) progressFun, required Function() endFun}) async {
  startFun();

  try {
    // Check for storage permission
    var status1 = await Permission.storage.request();
    var status2 = await Permission.manageExternalStorage.request();
    if (!status1.isGranted && !status2.isGranted) {
      endFun();
      return;
    }

    String fileName = isVideo ? 'story_video_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}.mp4' : 'story_image_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}.jpg';
    String filePath = '/storage/emulated/0/Download/$fileName';

    // Download media using Dio package with progress callback
    Dio dio = Dio();

    await dio.download(
      mediaUrl,
      filePath,
      onReceiveProgress: (received, total) => progressFun(received, total),
    );

    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Media downloaded to $filePath')),
      );
    }
    endFun();
  } catch (e) {
    //print(e);
    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading media: $e')),
      );
    }
    endFun();
  }
}*/
