import 'package:chat_max/bloc/auth/auth_bloc.dart';
import 'package:chat_max/repository/auth_repository.dart';
import 'package:chat_max/screens/auth_screen.dart';
import 'package:chat_max/screens/home_screen.dart';
import 'package:chat_max/utils/theme_data.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        // Add the locale here
        builder: DevicePreview.appBuilder,
        title: 'Chat Max',
        debugShowCheckedModeBanner: false,
        theme: CustomThemeData().themeData(context),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapShot) {
              if (userSnapShot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (userSnapShot.hasData) {
                return HomeScreen();
              }
              return AuthScreen();
            }),
      ),
    );
  }
}
