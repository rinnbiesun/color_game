import '../app_color.dart';
import '../services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/firebase_database.dart';
import 'home_page.dart';

class NameInputDialog extends ConsumerStatefulWidget {
  const NameInputDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NameInputDialogState();
}

class _NameInputDialogState extends ConsumerState<NameInputDialog> {
  late final TextEditingController _controller;

  final DatabaseProvider db = DatabaseProvider();

  Future<void> savePlayerName(String name) async {
    await db.updateName(name);
    final profile = await db.getProfile();
    final deviceId = profile?.id ?? '';
    FirebaseDbManager.updateName(deviceId, name);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = ref.read(playerNameProvider);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const outlineInputBorder = OutlineInputBorder(
        borderSide:
            BorderSide(color: Color(AppColor.generalTextColor), width: 1));

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        color: const Color(AppColor.generalBackgroundColor),
        padding: const EdgeInsets.all(20),
        width: screenSize.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.playerName,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: const Color(AppColor.generalTextColor)),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.name,
              maxLength: 20,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
              style: const TextStyle(color: Color(AppColor.generalTextColor)),
              autofocus: true,
              decoration: InputDecoration(
                labelStyle:
                    const TextStyle(color: Color(AppColor.generalTextColor)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                labelText: AppLocalizations.of(context)!.playerNameHint,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color(AppColor.buttonBackgroundColor),
                  padding: const EdgeInsets.symmetric(horizontal: 56)),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  ref.read(playerNameProvider.notifier).state =
                      _controller.text;
                  savePlayerName(_controller.text);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.confirm,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: const Color(AppColor.generalTextColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
