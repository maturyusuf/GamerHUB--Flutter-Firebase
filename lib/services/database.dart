import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_gamers/models/member.dart';

class DataBaseService {
  final String? uid;

  DataBaseService({
    this.uid,
  });

  final CollectionReference gamerCollection =
      FirebaseFirestore.instance.collection("gamer");

  Stream<List<Member>> get members {
    return gamerCollection.orderBy("createdAt",descending: false).snapshots().map((snapshot) {
      return memberListfromSnapshot(snapshot);
    });
  }

  List<Member> memberListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Member(
          firstName: doc.get("firstName"),
          lastName: doc.get("lastName"),
          age: doc.get("age"),
          gender: doc.get("gender"),
          favGame: doc.get("favGame"));
    }).toList();
  }

  Future updateData(String firstName, String lastName, int age, String favGame,
      String gender) async {
    return await gamerCollection.doc(uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "age": age,
      "favGame": favGame,
      "gender": gender,
      "createdAt": FieldValue.serverTimestamp()
    }, SetOptions(merge: true));
  }
}
