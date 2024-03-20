import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_management/screens/splash_screen.dart';
import 'package:get_storage/get_storage.dart';

void main()async {
  await dotenv.load(fileName: '.env');
  await GetStorage.init();
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
      primaryColor: Colors.amber,
      ),
      home: SplashScreen(),
    );
  }
}
