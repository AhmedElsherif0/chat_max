import 'package:chat_max/bloc/auth/auth_bloc.dart';
import 'package:chat_max/repository/auth_repository.dart';
import 'package:chat_max/screens/auth_screen.dart';
import 'package:chat_max/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
      ],
      child: MaterialApp(
        title: 'Chat Max',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            backgroundColor: Colors.lightBlue,
            accentColor: Colors.indigo,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.blue,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
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
