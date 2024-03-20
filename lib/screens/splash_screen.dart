import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_management/screens/home_screen.dart';
import 'package:user_management/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Image.asset(
          'assets/images/centa_C_logo.png',
          width: 100,
        )),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    final _user = await GetStorage().read('user');
    await Future.delayed(const Duration(seconds: 3));
    if (_user != null && _user.isNotEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (cntx) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (cntx) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }
}
