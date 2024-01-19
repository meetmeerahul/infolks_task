import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infolks_task/models/user_model.dart';
import 'package:infolks_task/screens/bottom_nav.dart';

import 'package:infolks_task/screens/splash_scree.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());

  SharedPreferences pref = await SharedPreferences.getInstance();
  var logged = pref.getBool("isLogged");

  runApp(MaterialApp(
    home: logged == false ? const MyApp() : const HomePage(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
