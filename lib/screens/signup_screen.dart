import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:infolks_task/models/user_model.dart';
import 'package:infolks_task/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _mobile,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Mobile Number",
              label: Text("Mobile Number"),
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
              signup(_name.text.toLowerCase().trim(), _password.text.trim(),
                  _mobile.text.trim(), context);
            },
            child: const Text("Signup"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          ),
          child: const Text(
            "Already Have An Account ???",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        )
      ]),
    );
  }

  signup(
      String username, String password, String mobile, BuildContext ctx) async {
    var box = await Hive.openBox<UserModel>("userbox");

    var users = box.values.toList();

    bool status = true;

    for (var user in users) {
      if (user.name == username || user.mobile == mobile) {
        status = false;
        break;
      }
    }

    if (status == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username or mibile already registered"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      UserModel user =
          UserModel(name: username, password: password, mobile: mobile);

      box.add(user);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User registred"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const LoginScreen()),
      );
    }
  }
}
