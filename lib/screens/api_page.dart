import 'package:flutter/material.dart';
import 'package:infolks_task/api/api_handler.dart';
import 'package:infolks_task/models/user_details.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  Future<List<UserDetails>>? userDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userDetails = getDetailsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<UserDetails>>(
        future: userDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                var data = snapshot.data![index];
                return ListTile(
                  leading: Column(
                    children: [
                      Text(data.name.toString()),
                      Text(data.email.toString()),
                      Text(data.department.toString()),
                      Text(data.ifId.toString()),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
        },
      ),
    );
  }

  Future<List<UserDetails>>? getDetailsFromApi() async {
    return await ApiUserDetails.getDetails();
  }
}
