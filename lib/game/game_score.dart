import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_color.dart';

final scoreProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

class ScoreText extends ConsumerWidget {
  const ScoreText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreProvider);
    return Text('Score $score',
        style: const TextStyle(
            color: Color(AppColor.generalTextColor), fontSize: 20));
  }
}
