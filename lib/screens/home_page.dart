import 'package:firebase_gamers/models/member.dart';
import 'package:firebase_gamers/services/authentication.dart';
import 'package:firebase_gamers/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Member>>.value(
      value: DataBaseService().members,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
          actions: [
            IconButton(
                onPressed: () {
                  AuthService().signOut();
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Center(
          child: membersList(),
        ),
      ),
    );
  }
}

class membersList extends StatelessWidget {
  const membersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<List<Member>>(context);
    return ListView.builder(
        itemCount: members.length,
        itemBuilder: ((context, index) {
          return Center(
            child: InkWell(
              onTap: () {
                showBottomSheet(
                  backgroundColor: Colors.grey[400],
                  elevation: 1,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 250,
                        alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:15.0),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: members[index].gender=="Male" ? AssetImage("images/male.png") : AssetImage("images/female.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: SizedBox(
                                  
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                  Text("Name: ${members[index].firstName} ${members[index].lastName}"),
                                  Text("Age: ${members[index].age} "),
                                  Text("Favourite Game: ${members[index].favGame}"),
                                  Text("Favourite Game: ${members[index].favGame}"),
                                                        ],
                                                      ),
                                ),
                              ),
                            ],
                          ));
                    });
              },
              child: Card(
                child: ListTile(
                  leading: members[index].gender == "Male"
                      ? Icon(Icons.male)
                      : Icon(Icons.female),
                  title: Text(
                      "${members[index].firstName} ${members[index].lastName}"),
                ),
              ),
            ),
          );
        }));
  }
}
