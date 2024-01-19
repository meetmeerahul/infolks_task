import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:infolks_task/models/user_model.dart';
import 'package:infolks_task/screens/bottom_nav.dart';
import 'package:infolks_task/screens/signup_screen.dart';

import "package:shared_preferences/shared_preferences.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Username",
              label: Text("Username"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _password,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Password",
              label: Text("Password"),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 300,
          child: TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.teal),
            ),
            onPressed: () {
              login(_name.text.toLowerCase().trim(), _password.text.trim(),
                  context);
            },
            child: const Text("Login"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupScreen(),
            ),
          ),
          child: const Text(
            "Dont Have An Account ???",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        )
      ]),
    );
  }

  login(String name, String password, BuildContext ctx) async {
    var box = await Hive.openBox<UserModel>('userbox');

    bool success = false;

    var users = box.values.toList();

    for (var user in users) {
      if (user.name == name && user.password == password) {
        success = true;
        break;
      }
    }

    if (success == true) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isLogged", true);
      pref.setString("user", name);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (ctx) => const HomePage(),
          ),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Credentials"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
