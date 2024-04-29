import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/HomeScreen.dart';
import 'package:task_app/screen/signin.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final auth = FirebaseAuth.instance;

  final namedController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void deactivate() {
    namedController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.deactivate();
  }

  final formKey = GlobalKey<FormState>();
  bool passwordObscured = true;
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
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Create your account',
                    style: TextStyle(color: Colors.black),
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
                            child: Icon(Icons.person, color: Colors.grey),
                          ),
                          Expanded(
                              child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                            },
                            controller: namedController,
                            decoration: InputDecoration(
                                hintText: 'User name',
                                border: InputBorder.none),
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
                            child: Icon(Icons.email, color: Colors.grey),
                          ),
                          Expanded(
                              child: TextFormField(
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
                            controller: emailController,
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              }
                            },
                            obscureText: passwordObscured,
                            controller: passwordController,
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
                          await auth.createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Successful')),
                          );

                          // Navigate to HomeScreen after successful signup
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        }
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[200]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                           onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Signin()));
                          },
                          child: Text(
                            'Login',
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
