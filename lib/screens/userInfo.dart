import 'package:flutter/material.dart';
import 'package:user_management/widgets/custom_app.dart';

class UserInfo extends StatelessWidget {
  final String userName;
  final String email;
  UserInfo({
    super.key,
    required this.userName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(name: userName),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Back To Home')),
      ),
    );
  }
}
