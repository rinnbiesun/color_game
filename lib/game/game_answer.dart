import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_color.dart';
import 'game_model.dart';
import 'game_question.dart';
import 'game_score.dart';

class AnswerNotifier extends StateNotifier<List<GameItem>> {
  AnswerNotifier() : super([]);

  final colorLength = 6;

  List<GameItem> getAnswers() {
    var gameItems = <GameItem>[];
    final tempColorKeyList = <String>[...AppColor.colorKeys];
    final tempColorList = <Color>[...AppColor.colorList];

    for (var i = 0; i < colorLength; i++) {
      final randomColorKeyIndex = Random().nextInt(tempColorKeyList.length);
      final randomColorIndex = Random().nextInt(tempColorList.length);

      final randomColorKey = tempColorKeyList[randomColorKeyIndex];
      final randomColor = tempColorList[randomColorIndex];

      gameItems.add(GameItem(key: randomColorKey, color: randomColor));

      tempColorKeyList.remove(randomColorKey);
      tempColorList.remove(randomColor);
    }
    return gameItems;
  }

  void refreshAnswers() {
    state = getAnswers();
  }
}

final answerNotifierProvider =
    StateNotifierProvider.autoDispose<AnswerNotifier, List<GameItem>>((ref) {
  return AnswerNotifier();
});

class ColorAnswer extends ConsumerWidget {
  const ColorAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameItems = ref.watch(answerNotifierProvider);
    const rowCount = 3;
    const itemCountPerRow = 2;
    /*
    [0, 1, 2, 3, 4, 5]
    row 0 -> 0, 1
    row 1 -> 2, 3
    row 2 -> 4, 5

    start = 0, end = 2
    start = 2, end = 4
    start = 4, end = 6
    */
    return Column(children: [
      for (var i = 0; i < rowCount; i++)
        ColorButtonRow(
          rowItems: gameItems
              .getRange(i * itemCountPerRow, (i + 1) * itemCountPerRow)
              .toList(),
        )
    ]);
  }
}

class ColorButtonRow extends StatelessWidget {
  const ColorButtonRow({Key? key, required this.rowItems}) : super(key: key);

  final List<GameItem> rowItems;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (var item in rowItems)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ColorButton(
              colorKey: item.key,
              color: item.color,
            ),
          ),
        ),
    ]);
  }
}

class ColorButton extends ConsumerWidget {
  const ColorButton({Key? key, required this.colorKey, required this.color})
      : super(key: key);

  final String colorKey;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Container(
        width: 200,
        height: 100,
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
            color: Color(AppColor.buttonBackgroundColor),
            shape: BoxShape.rectangle,
            border: null,
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Text(
          getColorName(context, colorKey),
          style: TextStyle(
              color: color, fontSize: 35, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        final answer = ref.read(gameQuestionProvider);
        final answerColorKey = AppColor.colorsConfig.keys
            .firstWhere((key) => AppColor.colorsConfig[key] == answer.color);
        final isCorrect = colorKey == answerColorKey;
        if (isCorrect) {
          ref.read(scoreProvider.notifier).state += 10;
          ref.read(answerNotifierProvider.notifier).refreshAnswers();
        }
        stdout.writeln('isCorrect = $isCorrect');
      },
    );
  }
}
