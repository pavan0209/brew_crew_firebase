class UserModel {
  final String userId;

  UserModel({required this.userId});
}

class UserBrewDataModel {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserBrewDataModel({
    required this.uid,
    required this.name,
    required this.sugars,
    required this.strength,
  });
}
