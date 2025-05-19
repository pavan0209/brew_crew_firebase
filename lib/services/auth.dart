import 'package:firebase_auth/firebase_auth.dart';

import 'package:brew_crew_firebase/models/index.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Convert Firebase [User] to our custom [UserModel]
  UserModel? _userFromFirebaseUser(User? user) {
    if (user == null) return null;
    return UserModel(userId: user.uid);
  }

  /// Firebase user auth state changes
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  /// Sign in anonymously
  Future<UserModel?> signInAnonymous() async {
    try {
      final result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print("Anonymous sign-in error: $e");
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Sign out error: $e");
    }
  }

}
