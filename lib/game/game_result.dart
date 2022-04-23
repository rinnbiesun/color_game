import '../app_route.dart';
import '../home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/database.dart';
import '../services/firebase_database.dart';
import 'game_data.dart';

class GameResultPage extends StatefulWidget {
  const GameResultPage({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  State<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {
  final DatabaseProvider db = DatabaseProvider();

  Future<void> _submitScore(int score, Function(void) onSubmitSuccess) async {
    final profile = await db.getProfile();
    final deviceId = profile?.id ?? '';
    await db.updateScore(score);

    FirebaseDbManager.updateScore(deviceId, score, onSubmitSuccess, () {
      // onError
    });
  }

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
              child: Text(widget.score.toString(),
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
            const SizedBox(
              width: 0.0,
              height: 48.0,
            ),
            HomeCard(
              text: AppLocalizations.of(context)!.submitScore,
              onTap: () {
                _submitScore(widget.score, (_) {
                  final snackBar = SnackBar(
                    content: Text(
                        AppLocalizations.of(context)!.submitScoreSuccessMsg),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
