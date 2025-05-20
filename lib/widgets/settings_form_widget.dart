import 'package:flutter/material.dart';

import 'package:brew_crew_firebase/widgets/index.dart';

class SettingsFormWidget extends StatefulWidget {
  const SettingsFormWidget({super.key});

  @override
  State<SettingsFormWidget> createState() => _SettingsFormWidgetState();
}

class _SettingsFormWidgetState extends State<SettingsFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  String _currentSugars = '0';
  int _currentStrength = 100;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text('Update your brew settings.', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 30),
          TextFormField(
            controller: _nameController,
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
              _formKey.currentState!.validate();
            },
          ),
          const SizedBox(height: 20),
          ButtonTheme(
            child: DropdownButtonFormField(
              value: _currentSugars,
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
            value: _currentStrength.toDouble(),
            min: 100,
            max: 900,
            divisions: 8,
            activeColor: Colors.brown[_currentStrength],
            inactiveColor: Colors.brown[200],
            onChanged: (value) {
              setState(() {
                _currentStrength = value.round();
              });
            },
          ),
          const SizedBox(height: 30),
          AppElevatedButton(
            onPressed: () async {},
            label: 'Update',
          ),
        ],
      ),
    );
  }
}
