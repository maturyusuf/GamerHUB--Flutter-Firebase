import 'package:firebase_gamers/launch.dart';
import 'package:firebase_gamers/screens/home_page.dart';
import 'package:firebase_gamers/user.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if(user == null) {
      return Launch();
    }
    else{
      return Home();
    }
  }
}