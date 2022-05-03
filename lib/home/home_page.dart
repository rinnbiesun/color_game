import 'dart:io';

import '../app_route.dart';
import '../app_color.dart';
import '../game/game_model.dart';
import '../services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/firebase_database.dart';
import 'home_dialogs.dart';

const platformAndroid = 'android';
const platformIos = 'ios';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final DatabaseProvider db = DatabaseProvider();

  var _deviceId = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    final profile = await db.getProfile();

    var deviceId = profile?.id ?? '';
    var platform = profile?.platform ?? '';
    final name = profile?.name ?? '';
    final score = profile?.score ?? 0;

    if (deviceId.isEmpty) {
      try {
        if (Platform.isAndroid) {
          AndroidDeviceInfo android = await _deviceInfoPlugin.androidInfo;
          deviceId = android.androidId ?? '';
          platform = platformAndroid;
        } else if (Platform.isIOS) {
          IosDeviceInfo ios = await _deviceInfoPlugin.iosInfo;
          deviceId = ios.identifierForVendor ?? '';
          platform = platformIos;
        }
        stdout.writeln(
            'deviceId = $deviceId, platform = $platform, name = $name, score = $score');
      } on PlatformException {
        stdout.writeln('Error: Failed to get platform version.');
      }

      if (deviceId.isNotEmpty && platform.isNotEmpty) {
        db.insertProfile(Profile(id: deviceId, platform: platform));
      }
      FirebaseDbManager.initUser(deviceId,
          {"id": deviceId, "name": name, "platform": platform, "score": score});
    } else {
      stdout.writeln(
          'deviceId = $deviceId, platform = $platform, name = $name, score = $score');
    }

    if (!mounted) return;

    ref.watch(playerNameProvider.notifier).state = name;

    setState(() {
      _deviceId = deviceId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColor.generalBackgroundColor),
      appBar: null,
      resizeToAvoidBottomInset:
          false, // prevent keyboard open will resize other widgets
      body: SafeArea(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppInfoText(uuid: _deviceId),
              const Expanded(flex: 1, child: Center(child: GreetingText())),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HomeCard(
                      text: AppLocalizations.of(context)!.start,
                      onTap: () => {
                        if (ref.read(playerNameProvider).isEmpty)
                          {
                            showDialog(
                                context: context,
                                builder: (context) => const NameInputDialog())
                          }
                        else
                          {Navigator.pushNamed(context, AppRoute.game)}
                      },
                    ),
                    const SizedBox(
                      width: 0.0,
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: HomeHalfCard(
                            text: AppLocalizations.of(context)!.leaderboard,
                            onTap: () => {
                              Navigator.pushNamed(context, AppRoute.leaderboard)
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: HomeHalfCard(
                            text: AppLocalizations.of(context)!.settings,
                            onTap: () => {
                              showDialog(
                                  context: context,
                                  builder: (context) => const NameInputDialog())
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class AppInfoText extends StatelessWidget {
  const AppInfoText({
    Key? key,
    required String uuid,
  })  : _uuid = uuid,
        super(key: key);

  final String _uuid;

  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(color: Color(AppColor.generalTextColor), fontSize: 8.0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            'ID $_uuid',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

final playerNameProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

class GreetingText extends ConsumerWidget {
  const GreetingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = ref.watch(playerNameProvider);
    return Text(
      AppLocalizations.of(context)!.greeting(name),
      style: const TextStyle(
          fontSize: 36.0, color: Color(AppColor.generalTextColor)),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          padding: const EdgeInsets.all(50.0),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 36.0, color: Color(AppColor.generalTextColor)),
          ),
          decoration: const BoxDecoration(
              color: Color(AppColor.buttonBackgroundColor),
              shape: BoxShape.rectangle,
              border: null,
              borderRadius: BorderRadius.all(Radius.circular(30.0)))),
    );
  }
}

class HomeHalfCard extends StatelessWidget {
  const HomeHalfCard({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 36.0, color: Color(AppColor.generalTextColor)),
          ),
          decoration: const BoxDecoration(
              color: Color(AppColor.buttonBackgroundColor),
              shape: BoxShape.rectangle,
              border: null,
              borderRadius: BorderRadius.all(Radius.circular(30.0)))),
    );
  }
}
