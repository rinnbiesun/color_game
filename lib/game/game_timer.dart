import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'game_data.dart';

class TimerText extends StatefulWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
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
    return Text(counter.toString(),
        style: const TextStyle(
            color: Color(AppColor.generalTextColor), fontSize: 20));
  }
}
