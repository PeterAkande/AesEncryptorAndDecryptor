import 'package:aes_encryptor_app/app_state/aes_encryptor_state.dart';
import 'package:aes_encryptor_app/app_theme.dart';
import 'package:aes_encryptor_app/screens/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AesEncryptorState(), // The handler of the app state, to be provided to all child widgets with Provider
        builder: (context, widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AesEncryptorTheme.light(), // Light theme
            darkTheme: AesEncryptorTheme.dark(), // Dark Theme
            home: const Home(),
          );
        });
  }
}
