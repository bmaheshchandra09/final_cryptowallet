import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:cryptowallet/pages/googlesigninprovider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Container(
          height: 400,
          margin: const EdgeInsets.all(30),
          child: Center(
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
        Container(
            child: SignInButton(
              Buttons.Google,
              text: "Sign-up with Google",
              onPressed: () {
                final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
            )),
        Container(
            child: SignInButton(
              Buttons.Facebook,
              text: "Sign-up with Facebook",
              onPressed: () {},
            ))
      ]),
    );
  }
}
