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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaJGnx3ViMatru5nEArag-DIbB8X7Rg-A',
    appId: '1:795469653274:android:d665f55e9efbbd10b5b8a3',
    messagingSenderId: '795469653274',
    projectId: 'absensiapp-977fd',
    databaseURL: 'https://absensiapp-977fd-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'absensiapp-977fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2tNo6ag3qZ8EgCGlT_lL4w4q9PWZJBgs',
    appId: '1:795469653274:ios:c0240da0549b6e5bb5b8a3',
    messagingSenderId: '795469653274',
    projectId: 'absensiapp-977fd',
    databaseURL: 'https://absensiapp-977fd-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'absensiapp-977fd.appspot.com',
    iosBundleId: 'com.example.uber',
  );
}