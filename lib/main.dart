import 'dart:io';

import 'package:ecommerce2/pages/add_food.dart';
import 'package:ecommerce2/pages/admin_login.dart';
import 'package:ecommerce2/pages/bottomnav.dart';
import 'package:ecommerce2/pages/home.dart';
import 'package:ecommerce2/pages/home_admin.dart';
import 'package:ecommerce2/pages/login.dart';
import 'package:ecommerce2/pages/onboard.dart';
import 'package:ecommerce2/pages/signup.dart';
import 'package:ecommerce2/services/sharedpreferences.dart';
import 'package:ecommerce2/widget/app_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=publishableKey;
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAqL-9i-00mOF42IwmYe5CGgvngjj2x9jo',
              appId: '1:3827273699:android:2f1966d07446a856689ad6',
              messagingSenderId: '3827273699',
              projectId: 'fooddeliveryapp-b3685',
              storageBucket: 'fooddeliveryapp-b3685.appspot.com'
          ))
      : await Firebase.initializeApp();

  SharedPreferencesHelper prefs = SharedPreferencesHelper();
  bool isFirstTime = await prefs.isFirstTime();
  bool isLoggedIn = await prefs.getUserId() != null;


  runApp(MyApp(
    isFirstTime: isFirstTime,
    isLoggedIn: isLoggedIn,
  ));



}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isFirstTime, required this.isLoggedIn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isFirstTime ? OnBoard() : (isLoggedIn ? BottomNav() : Login()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
