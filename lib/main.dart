import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sound_of_ai/auth.dart';
import 'package:sound_of_ai/login.dart';
import 'package:sound_of_ai/page1.dart';
import 'package:sound_of_ai/register.dart';
import 'package:sound_of_ai/graphs.dart';
import 'package:sound_of_ai/otp.dart';
import 'package:sound_of_ai/phone.dart';
import 'package:sound_of_ai/home.dart';
import 'package:get/get.dart';
import "dart:io";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(Auth()));
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes:{
      'login':(context)=> MyLogin(),
      'register':(context)=> MyRegister(),
      'graphs':(context)=>MyGraphs(),
      'phone': (context) => MyPhone(),
      'otp': (context) => MyOtp(),
      'home': (context) => MyHome(),
      'page':(context)=> HomePage()
    },
  ));
}