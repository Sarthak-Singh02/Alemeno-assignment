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
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAs2U2sI451Sk9mlF_HETw1I5nU6fWVVjY',
    appId: '1:484332269153:web:74b7181ba88477233ac420',
    messagingSenderId: '484332269153',
    projectId: 'alemeno-29255',
    authDomain: 'alemeno-29255.firebaseapp.com',
    storageBucket: 'alemeno-29255.appspot.com',
    measurementId: 'G-1P1VDM2M2K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASWWi9NGI7NRjyvs4SkocsohPWzB5Itgk',
    appId: '1:484332269153:android:2da296f2c33dd3d73ac420',
    messagingSenderId: '484332269153',
    projectId: 'alemeno-29255',
    storageBucket: 'alemeno-29255.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBECtSZjT1xW-NCESouhGiz9cGooRpqVtk',
    appId: '1:484332269153:ios:942f2deb4c50f5ca3ac420',
    messagingSenderId: '484332269153',
    projectId: 'alemeno-29255',
    storageBucket: 'alemeno-29255.appspot.com',
    iosClientId: '484332269153-qc1bueas7e1ouu63oqi8i9k0r28gj75i.apps.googleusercontent.com',
    iosBundleId: 'com.example.alemeno',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBECtSZjT1xW-NCESouhGiz9cGooRpqVtk',
    appId: '1:484332269153:ios:942f2deb4c50f5ca3ac420',
    messagingSenderId: '484332269153',
    projectId: 'alemeno-29255',
    storageBucket: 'alemeno-29255.appspot.com',
    iosClientId: '484332269153-qc1bueas7e1ouu63oqi8i9k0r28gj75i.apps.googleusercontent.com',
    iosBundleId: 'com.example.alemeno',
  );
}
