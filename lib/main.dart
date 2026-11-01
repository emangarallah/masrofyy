
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:masrofyy/firebase_options.dart';

import 'app.dart';
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await EasyLocalization.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
await GoogleSignIn.instance.initialize(
  serverClientId:"123714650543-tp9sl21roqbkmom1lv58pbg545hk7017.apps.googleusercontent.com",

);

await GoogleSignIn.instance.initialize();


  runApp(ProviderScope(child: MyApp()));
}
