import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:brew_crew_firebase/services/index.dart';
import 'package:brew_crew_firebase/utils/index.dart';
import 'package:brew_crew_firebase/widgets/index.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  const RegisterPage({super.key, required this.toggleView});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Register to Brew Crew', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset('assets/images/coffee_mug.png', height: MediaQuery.of(context).size.height * 0.3),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'email is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'email',
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is required';
                    } else if (value.length < 8) {
                      return 'password length should be at least 8 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'password',
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                AppElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text.toString();
                      final password = _passwordController.text.toString();
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if (result is String) {
                        AppToast.showError(context, result);
                      }
                    }
                  },
                  label: 'Register & Login',
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Have an account? ',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(fontSize: 18, color: Colors.brown[500], fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.toggleView();
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
