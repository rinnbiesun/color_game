import 'package:firebase_database/firebase_database.dart';

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

  static Future<void> updateName(String deviceId, String name) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$deviceId");

    await ref.update({
      "name": name,
    });
  }

  static Future<void> updateScore(String deviceId, int score,
      Function(void) onSuccess, Function onError) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$deviceId");

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
