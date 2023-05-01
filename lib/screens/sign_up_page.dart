import 'dart:ffi';

import 'package:firebase_gamers/launch.dart';
import 'package:firebase_gamers/services/authentication.dart';
import 'package:firebase_gamers/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;
  SignUpPage({required this.toggleView, super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

GlobalKey _formkey = GlobalKey<FormState>();

class _SignUpPageState extends State<SignUpPage> {
  AuthService _auth = AuthService();
  String? firstName;
  String? lastName;
  int? age;
  String? favGame;
  String? gender;
  String? email;
  String? password;
  String ageValidator = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Sign Up Page"),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.arrow_back),
              label: Text("Sign In"))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? "Enter your first name" : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      firstName = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      hintText: "First Name",
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
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      hintText: "Last Name",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.blue))),
                  validator: (value) {
                    return value!.isEmpty ? "Enter your last name" : null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  onChanged: (value) {
                    try {
                      setState(() {
                        age = int.parse(value);
                      });
                    } on Exception catch (e) {
                      null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      hintText: "Your Age",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.blue))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your age";
                    }

                    try {
                      var new_age = int.parse(value);
                    } catch (e) {
                      return "Enter a number as your age";
                    }
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? "Enter your favourite game" : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      favGame = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green)),
                      hintText: "Your Favourite Game",
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
                  validator: (value) {
                    return value!.isEmpty ? "Enter your Email" : null;
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
                SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? "Enter your password" : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
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
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 150,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.green)),
                  child: DropdownButton(
                      value: gender ?? null,
                      hint: Text("Your gender"),
                      items: [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(
                            value: "Female", child: Text("Female")),
                        DropdownMenuItem(value: "Other", child: Text("Other"))
                      ],
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      }),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      print(firstName);
                      print(lastName);
                      print(email);
                      print(password);
                      if (firstName == null ||
                          lastName == null ||
                          age == null ||
                          gender == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Please fill the required fields correctly")));
                      } else {
                        dynamic isRegistered =
                            await _auth.register(email!, password!);
                        if (isRegistered == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Please fill the email and password fields correctly")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("You've signed Up !")));
                          await DataBaseService().updateData(firstName!, lastName!, age!, favGame!, gender!);
                        }
                      }
                    },
                    child: Text("Sign Up !"),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
