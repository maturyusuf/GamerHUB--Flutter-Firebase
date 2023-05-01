import 'package:firebase_gamers/screens/home_page.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  const SignInPage({required this.toggleView, super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final GlobalKey _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? "Enter an email" : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.blue))),
                ),
                SizedBox(height: 15),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.blue))),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (value) {
                    return value!.length < 6
                        ? "Enter a password longer than 6 characters!"
                        : null;
                  },
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      print(email);
                      print(password);

                      dynamic isSigned = await _auth.signInWithEmailandPassword(
                          email, password);
                      print(isSigned);
                      isSigned == null
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Email or password is not found")))
                          : null;
                    },
                    child: Text("Sign In !"),
                  ),
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    widget.toggleView();
                  },
                  child: Text(
                    "Sign Up to GamerHub",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
