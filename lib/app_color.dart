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
  static const buttonBackgroundColor = 0xffffffff;

  static const colorBlue = Color(0xff0072b2);
  static const colorRed = Colors.red;
  static const colorGreen = Color(0xff009e73);
  static const colorYellow = Color(0xfff0e442);
  static const colorOrange = Color(0xffe69f00);
  static const colorPurple = Color(0xffcc79a7);
  static const colorBlack = Colors.black;
  static const colorSkyBlue = Color(0xff56b4e9);

  static const colorKeyBlue = 'blue';
  static const colorKeyRed = 'red';
  static const colorKeyGreen = 'green';
  static const colorKeyYellow = 'yellow';
  static const colorKeyOrange = 'orange';
  static const colorKeyPurple = 'purple';
  static const colorKeyBlack = 'black';
  static const colorKeySkyBlue = 'skyBlue';

  static const colorsConfig = {
    colorKeyBlue: colorBlue,
    colorKeyRed: colorRed,
    colorKeyGreen: colorGreen,
    colorKeyYellow: colorYellow,
    colorKeyOrange: colorOrange,
    colorKeyPurple: colorPurple,
    colorKeyBlack: colorBlack,
    colorKeySkyBlue: colorSkyBlue,
  };

  static const List<String> colorKeys = [
    colorKeyBlue,
    colorKeyRed,
    colorKeyGreen,
    colorKeyYellow,
    colorKeyOrange,
    colorKeyPurple,
    colorKeyBlack,
    colorKeySkyBlue,
  ];

  static const List<Color> colorList = [
    colorBlue,
    colorRed,
    colorGreen,
    colorYellow,
    colorOrange,
    colorPurple,
    colorBlack,
    colorSkyBlue,
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
    case AppColor.colorKeySkyBlue:
      return appLocalizations.skyBlue;
    case AppColor.colorKeyBlack:
      return appLocalizations.black;
    default:
      return '';
  }
}
