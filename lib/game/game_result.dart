import '../app_route.dart';
import '../home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/database.dart';
import '../services/firebase_database.dart';
import '../app_color.dart';

class GameResultPage extends StatefulWidget {
  const GameResultPage({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  State<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {
  final DatabaseProvider db = DatabaseProvider();
  var _highestScore = 0;

  @override
  void initState() {
    super.initState();
    _submitScore(widget.score);
    _getScoreRecord();
  }

  _getScoreRecord() async {
    final profile = await db.getProfile();
    final deviceId = profile?.id ?? '';
    final score = await FirebaseDbManager.getScore(deviceId);
    setState(() {
      _highestScore = score;
    });
  }

  Future<void> _submitScore(int score) async {
    final profile = await db.getProfile();
    final deviceId = profile?.id ?? '';
    final highestScore = profile?.score ?? 0;

    if (score > highestScore) {
      await db.updateScore(score);
      FirebaseDbManager.updateScore(deviceId, score, (_) {
        // onSuccess
      }, () {
        // onError
      });
    }
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.gameResult,
                        style: const TextStyle(
                          color: Color(AppColor.generalTextColor),
                          fontSize: 24.0,
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.highestScore,
                        style: const TextStyle(
                          color: Color(AppColor.generalTextColor),
                          fontSize: 24.0,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(widget.score.toString(),
                        style: const TextStyle(
                            color: Color(AppColor.generalTextColor),
                            fontSize: 36.0)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(_highestScore.toString(),
                        style: const TextStyle(
                            color: Color(AppColor.generalTextColor),
                            fontSize: 36.0)),
                  ),
                ),
              ],
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
