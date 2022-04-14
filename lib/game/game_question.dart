import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game_data.dart';
import 'game_answer.dart';

final gameQuestionProvider = Provider.autoDispose<GameItem>((ref) {
  final List<GameItem> answers = ref.watch(answerNotifierProvider);
  final randomColor = answers[Random().nextInt(answers.length)].color;
  final randomColorKey = answers[Random().nextInt(answers.length)].key;

  final answerColorKey = AppColor.colorsConfig.keys
      .firstWhere((key) => AppColor.colorsConfig[key] == randomColor);

  return GameItem(
      key: answerColorKey,
      color: AppColor.colorsConfig[randomColorKey] ?? Colors.black);
});

class ColorQuestion extends ConsumerStatefulWidget {
  const ColorQuestion({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ColorQuestionState();
}

class _ColorQuestionState extends ConsumerState<ColorQuestion> {
  @override
  void initState() {
    super.initState();
    ref.read(answerNotifierProvider.notifier).refreshAnswers();
  }

  @override
  Widget build(BuildContext context) {
    final answer = ref.watch(gameQuestionProvider);
    return Text(
      getColorName(context, answer.key),
      style: TextStyle(
          color: answer.color, fontSize: 50, fontWeight: FontWeight.bold),
    );
  }
}
