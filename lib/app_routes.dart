import 'package:ava_bavly_scouts/dynamic_path.dart';
import 'package:ava_bavly_scouts/main.dart';
import 'package:ava_bavly_scouts/story_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {

  static List<DynamicPath> paths = [
    DynamicPath(
      r'^/story/([\w-]+)$',
          (context, match) {
            final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
            return StoryScreen(
              isVideo: arguments['isVideo'],
              mediaUrl: arguments['mediaUrl'],
            );
          },
    ),
    DynamicPath(
      r'^' + MyHomePage.route,
          (context, match) => MyHomePage(),
    ),
  ];
}