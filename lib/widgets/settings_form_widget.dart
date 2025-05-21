import 'package:flutter/material.dart';

import 'package:brew_crew_firebase/widgets/index.dart';
import 'package:brew_crew_firebase/models/index.dart';
import 'package:brew_crew_firebase/services/index.dart';
import 'package:provider/provider.dart';

class SettingsFormWidget extends StatefulWidget {
  const SettingsFormWidget({super.key});

  @override
  State<SettingsFormWidget> createState() => _SettingsFormWidgetState();
}

class _SettingsFormWidgetState extends State<SettingsFormWidget> {
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserBrewDataModel>(
      stream: DatabaseService(uid: user.userId).userBrewData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserBrewDataModel userBrewData = snapshot.data!;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Update your brew settings.', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: userBrewData.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('name', style: TextStyle(color: Colors.black)),
                    hintText: 'name',
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (value) {
                    setState(() => _currentName = value);
                    _formKey.currentState!.validate();
                  },
                ),
                const SizedBox(height: 20),
                ButtonTheme(
                  child: DropdownButtonFormField(
                    value: _currentSugars ?? userBrewData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _currentSugars = value!;
                    },
                    decoration: InputDecoration(
                      hintText: 'select sugars',
                      label: const Text('select sugar', style: TextStyle(color: Colors.black)),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: (_currentStrength ?? userBrewData.strength).toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor: Colors.brown[_currentStrength ?? userBrewData.strength],
                  inactiveColor: Colors.brown[200],
                  onChanged: (value) {
                    setState(() => _currentStrength = value.round());
                  },
                ),
                const SizedBox(height: 30),
                AppElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.userId).updateUserData(
                        _currentSugars ?? userBrewData.sugars,
                        _currentName ?? userBrewData.name,
                        _currentStrength ?? userBrewData.strength,
                      );

                      Navigator.pop(context);
                    }
                  },
                  label: 'Update',
                ),
              ],
            ),
          );
        } else {
          return const AppLoader();
        }
      },
    );
  }
}
