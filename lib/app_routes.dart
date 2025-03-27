import 'package:ava_bavly_scouts/dynamic_path.dart';
import 'package:ava_bavly_scouts/pages/home_page/home_page_widget.dart';
import 'package:ava_bavly_scouts/pages/team_page/team_page_widget.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {

  static List<DynamicPath> paths = [
    /*DynamicPath(
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
      r'^' + OldHomePage.HomePage.route,
          (context, match) => OldHomePage.HomePage(),
    ),*/
    DynamicPath(
      r'^' + HomePageWidget.routePath,
          (context, match) => const HomePageWidget(),
    ),
    DynamicPath(
      r'^' + TeamPageWidget.routePath,
          (context, match) {
        final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
        return TeamPageWidget(
          name: arguments['name'],
          total_points: arguments['total_points'],
          rank: arguments['rank'],
          image: arguments['image'],
          nzam_points: arguments['nzam_points'],
          ro7y_points: arguments['ro7y_points'],
          ka4fy_points: arguments['ka4fy_points'],
          skafy_points: arguments['skafy_points'],
          games_points: arguments['games_points'],
          missions_points: arguments['missions_points'],
        );
      },
    ),
  ];
}