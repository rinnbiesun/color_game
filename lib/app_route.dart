class AppRoute {
  static const home = '/home';
  static const game = '/game';
  static const result = '/result';
}

class GameResultPageArguments {
  final int score;

  GameResultPageArguments(this.score);
}
