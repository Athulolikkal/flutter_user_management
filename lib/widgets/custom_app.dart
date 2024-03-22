import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_management/screens/login_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const CustomAppBar({super.key,required this.name});
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue[600],
      leading: const Icon(
        Icons.home,
        color: Colors.white,
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              GetStorage().remove('user');
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (cntx) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            )),
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      shadowColor: Colors.black,
      elevation: 20,
    );
  }
}
