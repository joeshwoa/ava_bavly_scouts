/*
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;

import 'package:flutter/material.dart';

Future<void> downloadFile(BuildContext context, {required Function() startFun, required bool isVideo, required String mediaUrl, required Function(int, int) progressFun, required Function() endFun}) async {
  startFun();

  try {
    String fileName = isVideo ? 'story_video_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}.mp4' : 'story_image_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}.jpg';
    String filePath = '/storage/emulated/0/Download/$fileName';

    // Download media using Dio package with progress callback
    Dio dio = Dio();

    if(kIsWeb) {
      final response = await dio.get(
        mediaUrl,
        onReceiveProgress: (received, total) => progressFun(received, total),
        options: Options(responseType: ResponseType.bytes),
      );

      final Uint8List bytes = Uint8List.fromList(response.data);

      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..style.display = 'none'
        ..target = '_blank';  // Open in a new tab instead of current one
      html.document.body!.append(anchor);
      anchor.click();
      anchor.remove();  // Remove the anchor element after download trigger

      // Cleanup the URL after download
      html.Url.revokeObjectUrl(url);
    }

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
