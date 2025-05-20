import 'package:brew_crew_firebase/models/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<BrewModel> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BrewModel(
        name: doc.get('name') ?? '',
        sugars: doc.get('sugars') ?? '',
        strength: doc.get('strength') ?? 0,
      );
    }).toList();
  }

  // user data from snapshot
  UserBrewDataModel _userBrewDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserBrewDataModel(
      uid: uid!,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  // get brews stream
  Stream<List<BrewModel>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user document stream
  Stream<UserBrewDataModel> get userData {
    return brewCollection.doc(uid).snapshots().map(_userBrewDataFromSnapshot);
  }
}
