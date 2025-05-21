import 'package:flutter/material.dart';

import 'package:brew_crew_firebase/models/index.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({super.key, required this.brew});
  final BrewModel brew;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.brown[50],
      margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.brown[brew.strength],
          backgroundImage: const AssetImage('assets/images/coffee_icon.png'),
        ),
        title: Text(brew.name),
        subtitle: Text('Takes ${brew.sugars} sugar(s)'),
      ),
    );
  }
}
