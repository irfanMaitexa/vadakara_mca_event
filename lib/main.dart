import 'package:event/Db/db_service.dart';
import 'package:event/modules/auth/login_screen.dart';
import 'package:event/modules/staff/staff_root_screen.dart';
import 'package:event/modules/user/user_root_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

   
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor:  Colors.white
      ),
      home: LoginScreen(),
    );
  }



  
}