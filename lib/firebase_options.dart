// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBzEHLUPFEkak46FnmWOYbVHz1SsY_Ssdw',
    appId: '1:395306354479:web:919384a527e315e38683da',
    messagingSenderId: '395306354479',
    projectId: 'color-game-827e1',
    authDomain: 'color-game-827e1.firebaseapp.com',
    databaseURL: 'https://color-game-827e1-default-rtdb.firebaseio.com',
    storageBucket: 'color-game-827e1.appspot.com',
    measurementId: 'G-SFKYX5KS67',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKdJrgDkrMZ-EPm-XdOyxg-YQK2vk0KNE',
    appId: '1:395306354479:android:a51c651796d9301b8683da',
    messagingSenderId: '395306354479',
    projectId: 'color-game-827e1',
    databaseURL: 'https://color-game-827e1-default-rtdb.firebaseio.com',
    storageBucket: 'color-game-827e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDO9y4BlorcEJT-_CqdimzZslzUW7Uooj8',
    appId: '1:395306354479:ios:a3f62a9b80e6c6bd8683da',
    messagingSenderId: '395306354479',
    projectId: 'color-game-827e1',
    databaseURL: 'https://color-game-827e1-default-rtdb.firebaseio.com',
    storageBucket: 'color-game-827e1.appspot.com',
    iosClientId: '395306354479-7vvh4u84052p7f442473e12pvjfnh3ku.apps.googleusercontent.com',
    iosBundleId: 'com.rinnbie.colorgame',
  );
}
