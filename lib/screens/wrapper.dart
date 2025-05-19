import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew_firebase/models/index.dart';
import 'package:brew_crew_firebase/screens/index.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    // Show authenticate page if user is not logged in
    if (user == null) {
      return const AuthenticatePage();
    } else {
      return HomePage();
    }
  }
}
