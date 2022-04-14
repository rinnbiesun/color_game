import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppColor {
  static const Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  static const appBarBackgroundColor = 0xffe9edc9;
  static const generalBackgroundColor = 0xffe9edc9;
  static const generalTextColor = 0xFF616161;
  static const buttonBackgroundColor = 0xfffefae0;

  static const colorBlue = Colors.blue;
  static const colorRed = Colors.red;
  static const colorGreen = Colors.green;
  static const colorYellow = Colors.yellow;
  static const colorOrange = Colors.orange;
  static const colorPurple = Colors.purple;
  static const colorBrown = Colors.brown;
  static const colorBlack = Colors.black;
  static const colorPink = Color(0xFFF06292);
  static const colorGrey = Colors.grey;

  static const colorKeyBlue = 'blue';
  static const colorKeyRed = 'red';
  static const colorKeyGreen = 'green';
  static const colorKeyYellow = 'yellow';
  static const colorKeyOrange = 'orange';
  static const colorKeyPurple = 'purple';
  static const colorKeyBrown = 'brown';
  static const colorKeyBlack = 'black';
  static const colorKeyPink = 'pink';
  static const colorKeyGrey = 'grey';

  static const colorsConfig = {
    colorKeyBlue: colorBlue,
    colorKeyRed: colorRed,
    colorKeyGreen: colorGreen,
    colorKeyYellow: colorYellow,
    colorKeyOrange: colorOrange,
    colorKeyPurple: colorPurple,
    colorKeyBrown: colorBrown,
    colorKeyBlack: colorBlack,
    colorKeyPink: colorPink,
    colorKeyGrey: colorGrey,
  };

  static const List<String> colorKeys = [
    colorKeyBlue,
    colorKeyRed,
    colorKeyGreen,
    colorKeyYellow,
    colorKeyOrange,
    colorKeyPurple,
    colorKeyBrown,
    colorKeyBlack,
    colorKeyPink,
    colorKeyGrey,
  ];

  static const List<Color> colorList = [
    colorBlue,
    colorRed,
    colorGreen,
    colorYellow,
    colorOrange,
    colorPurple,
    colorBrown,
    colorBlack,
    colorPink,
    colorGrey,
  ];
}

String getColorName(BuildContext context, String key) {
  final appLocalizations = AppLocalizations.of(context)!;
  switch (key) {
    case AppColor.colorKeyBlue:
      return appLocalizations.blue;
    case AppColor.colorKeyRed:
      return appLocalizations.red;
    case AppColor.colorKeyGreen:
      return appLocalizations.green;
    case AppColor.colorKeyYellow:
      return appLocalizations.yellow;
    case AppColor.colorKeyOrange:
      return appLocalizations.orange;
    case AppColor.colorKeyPurple:
      return appLocalizations.purple;
    case AppColor.colorKeyBrown:
      return appLocalizations.brown;
    case AppColor.colorKeyBlack:
      return appLocalizations.black;
    case AppColor.colorKeyPink:
      return appLocalizations.pink;
    case AppColor.colorKeyGrey:
      return appLocalizations.grey;
    default:
      return '';
  }
}

class GameItem {
  GameItem({required this.key, required this.color});

  final String key;
  final Color color;
}
