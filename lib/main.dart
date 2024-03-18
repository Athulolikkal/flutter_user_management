import 'package:flutter/material.dart';
import 'package:user_management/screens/splash_screen.dart';




void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    MaterialApp(
      title: 'Crud App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
