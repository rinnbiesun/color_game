import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

import '../game/game_model.dart';

class FirebaseDbManager {
  static final FirebaseDbManager _instance = FirebaseDbManager._internal();

  factory FirebaseDbManager() {
    return _instance;
  }

  FirebaseDbManager._internal();

  static initUser(String deviceId, Object user) async {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref("users/$deviceId");
    await dbRef.set(user);
  }

  static Future<List<Profile>> getLeaderboard() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users').get();
    if (snapshot.exists) {
      final List<Profile> players = [];
      final map = snapshot.value as Map<dynamic, dynamic>;

      map.forEach((key, value) {
        final map = Map<String, dynamic>.from(value);
        final player = Profile.fromMap(map);
        players.add(player);
      });

      return players;
    } else {
      return List.empty();
    }
  }

  static Future<int> getScore(String deviceId) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$deviceId/score').get();
    if (snapshot.exists) {
      stdout.writeln('snapshot.exists = ${snapshot.value.toString()}');
      return int.parse(snapshot.value.toString());
    } else {
      return 0;
    }
  }

  static Future<void> updateName(String deviceId, String name) async {
    final ref = FirebaseDatabase.instance.ref("users/$deviceId");

    await ref.update({
      "name": name,
    });
  }

  static Future<void> updateScore(String deviceId, int score,
      Function(void) onSuccess, Function onError) async {
    final ref = FirebaseDatabase.instance.ref("users/$deviceId");

    await ref
        .update({
          "score": score,
        })
        .then(onSuccess)
        .catchError((error) {
          onError;
        });
  }
}
