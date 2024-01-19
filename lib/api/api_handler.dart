import 'dart:convert';

import 'package:infolks_task/models/user_details.dart';

import 'package:http/http.dart' as http;

class ApiUserDetails {
  static Future<List<UserDetails>> getDetails() async {
    const url = "https://meetingapi.infolksgroup.com/api/user";
    final response = await http.get(Uri.parse(url));

    List tempList = [];

    if (response.statusCode == 200) {
      for (var v in jsonDecode(response.body)) {
        tempList.add(v);
      }
    }

    return UserDetails.getUserDetails(tempList);
  }
}
