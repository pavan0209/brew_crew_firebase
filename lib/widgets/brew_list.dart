import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_crew_firebase/models/index.dart';
import 'package:brew_crew_firebase/widgets/index.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewModel>>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        itemCount: brews.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        },
      ),
    );
  }
}
