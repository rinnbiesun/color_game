import 'dart:io';

import 'package:flutter/material.dart';

import '../app_color.dart';
import '../game/game_model.dart';
import '../services/firebase_database.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  var players = <Profile>[];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  _getUsers() async {
    final leaderboardResult = await FirebaseDbManager.getLeaderboard();
    stdout.writeln(leaderboardResult.toString());
    setState(() {
      players = leaderboardResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.generalBackgroundColor),
      appBar: AppBar(
        title: null,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Color(AppColor.generalTextColor)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: players.length,
        itemBuilder: (BuildContext context, int index) {
          final player = players[index];
          return Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                '${index + 1}',
                style:
                    const TextStyle(color: AppColor.colorBlack, fontSize: 48),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                player.name ?? '',
                style: const TextStyle(
                    color: Color(AppColor.generalTextColor), fontSize: 30),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                player.score.toString(),
                style: const TextStyle(
                    color: Color(AppColor.generalTextColor), fontSize: 30),
              )))
            ],
          );
        },
      ),
    );
  }
}
