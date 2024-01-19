import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:infolks_task/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String name = "";
String mobile = "";

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            mobile,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }

  void getDetails() async {
    var box = await Hive.openBox<UserModel>('userbox');
    var pref = await SharedPreferences.getInstance();
    String? username = pref.getString("user");

    var users = box.values.toList();

    for (var user in users) {
      if (user.name == username) {
        setState(() {
          name = user.name;
          mobile = user.mobile;
        });
      }
    }
  }
}
