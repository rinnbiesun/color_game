import 'game/game_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app_route.dart';
import 'app_color.dart';
import 'game/game_page.dart';
import 'home/home_page.dart';
import 'l10n/l10n.dart';
import 'leaderboard/leaderboard_page.dart';

///
/// TODO:
/// - Leaderboard
/// - Use themes to share colors and font styles
/// - Language settings
/// - Add CI/CD
/// - Firebase Crashlytics
/// - Run app on real iOS devices
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'color-game',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: const MaterialColor(
              AppColor.appBarBackgroundColor, AppColor.color)),
      initialRoute: AppRoute.home,
      onGenerateRoute: (route) => getRoute(route),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
    );
  }

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.home:
        return buildRoute(const HomePage(), settings: settings);
      case AppRoute.game:
        return buildRoute(const GamePage(), settings: settings);
      case AppRoute.leaderboard:
        return buildRoute(const LeaderboardPage(), settings: settings);
      case AppRoute.result:
        final arguments = settings.arguments as GameResultPageArguments;
        return buildRoute(GameResultPage(score: arguments.score),
            settings: settings);
      default:
        return null;
    }
  }

  MaterialPageRoute? buildRoute(Widget child, {RouteSettings? settings}) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => child,
    );
  }
}
