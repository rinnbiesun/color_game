import '../app_route.dart';
import '../home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'game_data.dart';

class GameResultPage extends StatelessWidget {
  const GameResultPage({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.generalBackgroundColor),
      appBar: null,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 100.0),
            Center(
              child: Text(AppLocalizations.of(context)!.gameResult,
                  style: const TextStyle(
                    color: Color(AppColor.generalTextColor),
                    fontSize: 36.0,
                  )),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Text(score.toString(),
                  style: const TextStyle(
                      color: Color(AppColor.generalTextColor), fontSize: 36.0)),
            ),
            const SizedBox(
              width: 0.0,
              height: 48.0,
            ),
            HomeCard(
              text: AppLocalizations.of(context)!.backHome,
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoute.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
