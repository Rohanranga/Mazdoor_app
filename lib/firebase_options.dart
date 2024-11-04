// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZ50myJZZxn4TPcpJMJA81EaDP3UrW6VU',
    appId: '1:206094610648:ios:a3419c6454c5aee76b67ad',
    messagingSenderId: '206094610648',
    projectId: 'easy-mazdoor-559d2',
    storageBucket: 'easy-mazdoor-559d2.firebasestorage.app',
    iosBundleId: 'com.example.mazdoorUser',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC454ElffCd7yQynG5Hr1KO-eMHGv8UC7E',
    appId: '1:206094610648:web:a0d5b1edc26d23d86b67ad',
    messagingSenderId: '206094610648',
    projectId: 'easy-mazdoor-559d2',
    authDomain: 'easy-mazdoor-559d2.firebaseapp.com',
    storageBucket: 'easy-mazdoor-559d2.firebasestorage.app',
    measurementId: 'G-S60RB1Q588',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZ50myJZZxn4TPcpJMJA81EaDP3UrW6VU',
    appId: '1:206094610648:ios:a3419c6454c5aee76b67ad',
    messagingSenderId: '206094610648',
    projectId: 'easy-mazdoor-559d2',
    storageBucket: 'easy-mazdoor-559d2.firebasestorage.app',
    iosBundleId: 'com.example.mazdoorUser',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAMjRQ3gSPE_399zktj-UKiOHp3a2tRx8',
    appId: '1:206094610648:android:f208b8f8f7c9d28b6b67ad',
    messagingSenderId: '206094610648',
    projectId: 'easy-mazdoor-559d2',
    storageBucket: 'easy-mazdoor-559d2.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC454ElffCd7yQynG5Hr1KO-eMHGv8UC7E',
    appId: '1:206094610648:web:b857cfb7274af1a46b67ad',
    messagingSenderId: '206094610648',
    projectId: 'easy-mazdoor-559d2',
    authDomain: 'easy-mazdoor-559d2.firebaseapp.com',
    storageBucket: 'easy-mazdoor-559d2.firebasestorage.app',
    measurementId: 'G-M78XGC1XZ8',
  );

}