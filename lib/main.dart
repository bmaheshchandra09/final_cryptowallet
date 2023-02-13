import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cryptowallet/pages/googlesigninprovider.dart';
import 'pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbapp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: "BlockChain ATM",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.yellow, fontFamily: 'Raleway'),
        home: FutureBuilder(
            future: _fbapp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("You have an erro ${snapshot.error.toString()}");
                return const Text("Oops! Something went wrong");
              } else if (snapshot.hasData) {
                const Text("Welcome");
                return Login();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
