import 'package:ava_bavly_scouts/app_routes.dart';
import 'package:ava_bavly_scouts/dynamic_path.dart';
import 'package:ava_bavly_scouts/pages/home_page/home_page_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.get('SUPABASEURL'),
    anonKey: dotenv.get('SUPABASEKEY'),
  );

  if (kIsWeb) {
    setPathUrlStrategy();
    MetaSEO().config();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AVA Bavly Scouts',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF101213)),
      initialRoute: HomePageWidget.routePath,
      onGenerateRoute: (settings) {
        for (DynamicPath path in AppRouter.paths) {
          final regExpPattern = RegExp(path.pattern);
          if (regExpPattern.hasMatch(settings.name!)) {
            final firstMatch = regExpPattern.firstMatch(settings.name!);
            final match = firstMatch!.group(0);
            return MaterialPageRoute<void>(
              builder: (context) => path.builder(context, match!),
              settings: settings,
            );
          }
        }
        // If no match is found, [WidgetsApp.onUnknownRoute] handles it.
        return null;
      },
    );
  }
}
