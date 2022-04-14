import 'package:flutter/material.dart';

import 'game_answer.dart';
import 'game_data.dart';
import 'game_question.dart';
import 'game_score.dart';
import 'game_timer.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.generalBackgroundColor),
      appBar: AppBar(
        title: null,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Color(AppColor.generalTextColor)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              const ScoreText(),
              Expanded(
                child: Container(
                  child: const TimerText(),
                  alignment: Alignment.topRight,
                ),
              )
            ]),
          ),
          const Expanded(
            child: Center(child: ColorQuestion()),
            flex: 1,
          ),
          const Expanded(
            child: ColorAnswer(),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
