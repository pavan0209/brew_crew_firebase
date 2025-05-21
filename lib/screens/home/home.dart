import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew_firebase/services/index.dart';
import 'package:brew_crew_firebase/widgets/index.dart';
import 'package:brew_crew_firebase/models/index.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<BrewModel>?>.value(
      value: DatabaseService().brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: const Text(
            'Brew Crew',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          actions: [
            IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.brown[200]),
              onPressed: () => _showSettingsPanel(context),
              icon: Icon(Icons.settings, color: Colors.brown[800]),
            ),
            const SizedBox(width: 5),
            IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.brown[200]),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => getAlertDialog(context),
                );
              },
              icon: Icon(Icons.logout_rounded, color: Colors.brown[800]),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const BrewList(),
        ),
      ),
    );
  }

  Widget getAlertDialog(context) {
    return AlertDialog(
      backgroundColor: Colors.brown[100],
      icon: Image.asset(
        'assets/images/coffee_mug.png',
        height: 100,
      ),
      content: const Text(
        'Are you sure you Log-Out from the application?',
        style: TextStyle(fontSize: 16, color: Colors.black87),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[600]),
          ),
        ),
        const SizedBox(width: 5),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await _auth.signOut();
          },
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.brown[600]),
          ),
        ),
      ],
    );
  }

  void _showSettingsPanel(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.brown[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(40, 20, 40, MediaQuery.of(context).viewInsets.bottom),
          child: const SingleChildScrollView(child: SettingsFormWidget()),
        );
      },
    );
  }
}
