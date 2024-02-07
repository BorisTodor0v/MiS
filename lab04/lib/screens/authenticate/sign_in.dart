import 'package:flutter/material.dart';
import 'package:lab03/services/auth.dart';
import 'package:lab03/shared/constants.dart';
import 'package:lab03/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        elevation: 0.0,
        title: const Text('Sign in'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: const Icon(Icons.person),
              label: const Text("Sign up"))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20,),
              TextFormField( // Email field
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                onChanged: (val) {
                  setState(() => email = val);
                },
                validator: (val) {
                  if(val != null && val.isEmpty){
                    return "Email can't be empty";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20,),
              TextFormField( // Password field
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                onChanged: (val){
                  setState(() => password = val);
                },
                validator: (val) {
                  if(val != null && val.isEmpty){
                    return "Password can't be empty";
                  } else if(val!.length < 6) {
                    return "Password must be at least 6 characters long";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                child: const Text("Sign in"),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState((){
                        loading = false;
                        error = "Invalid credentials";
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 20,),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
