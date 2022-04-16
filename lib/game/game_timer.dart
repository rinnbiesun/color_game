import 'package:flutter/material.dart';
import 'game_data.dart';

class TimerText extends StatelessWidget {
  const TimerText({Key? key, required this.counter}) : super(key: key);

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Text(counter.toString(),
        style: const TextStyle(
            color: Color(AppColor.generalTextColor), fontSize: 20.0));
  }
}
