import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/HomeScreen.dart';
import 'package:task_app/screen/signup.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  bool passwordObscured = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Task Management App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 70,
                    width: 300,
                    child: Material(
                      color: Colors.lightBlue[200],
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.email, color: Colors.grey),
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter an email";
                              } else if (!RegExp(
                                      '^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                                  .hasMatch(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Email', border: InputBorder.none),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    width: 300,
                    child: Material(
                      color: Colors.lightBlue[200],
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.password, color: Colors.grey),
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              }
                            },
                            obscureText: passwordObscured,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordObscured = !passwordObscured;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                    ))),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await auth
                              .signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim())
                              .then((value) {
                            if (value.user != null) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                  (route) => false);
                            }
                          });
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[200]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password',
                          style: TextStyle(color: Colors.lightBlue),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Signup()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.lightBlue),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
