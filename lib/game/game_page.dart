import 'dart:async';
import 'dart:io';

import '../app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game_answer.dart';
import '../app_color.dart';
import 'game_question.dart';
import 'game_score.dart';
import 'game_timer.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  var counter = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      this.timer = timer;
      stdout.writeln(timer.tick);
      counter--;
      setState(() {
        counter = counter;
      });

      if (counter == 0) {
        stdout.writeln('Cancel timer');
        timer.cancel();
        Navigator.pushReplacementNamed(context, AppRoute.result,
            arguments: GameResultPageArguments(ref.read(scoreProvider)));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    stdout.writeln('Cancel timer');
    timer?.cancel();
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              const ScoreText(),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: TimerText(counter: counter),
                ),
              )
            ]),
          ),
          Expanded(
            flex: 1,
            child: const Center(child: ColorQuestion()),
          ),
          Expanded(
            flex: 2,
            child: const ColorAnswer(),
          ),
        ],
      ),
    );
  }
}
