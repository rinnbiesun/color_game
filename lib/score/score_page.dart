import 'package:color_game/game/game_data.dart';
import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(AppColor.generalBackgroundColor),
        appBar: null,
        body: SafeArea(
          child: Center(
              child:
                  Text('Score', style: Theme.of(context).textTheme.headline2)),
        ));
  }
}
