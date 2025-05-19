import 'package:flutter/material.dart';

import 'package:brew_crew_firebase/services/index.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text('Brew Crew'),
        elevation: 0.0,
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: const Icon(Icons.person),
            label: const Text('logout'),
          )
        ],
      ),
    );
  }
}
