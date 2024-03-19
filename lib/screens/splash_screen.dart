
import 'package:flutter/material.dart';
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
          child: Text('Loading..........')
          // child: Image.network(
          //   "https://centa.org/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fnew-logo.8c938966.png&w=1080&q=75",
          //   width: 160,
          // ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed( const Duration(seconds: 3));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (cntx) => LoginScreen()));
  }
}