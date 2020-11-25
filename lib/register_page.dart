import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/auth_service.dart';
import 'package:whatsapp_clone_flutter/db.dart';
import 'package:whatsapp_clone_flutter/helper/helper_function.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final _formKey = GlobalKey<FormState>();
final FirebaseAuth _auth = FirebaseAuth.instance;
final TextEditingController controllerEmail = TextEditingController();
final TextEditingController controllerPassword = TextEditingController();
final TextEditingController controllerUsername = TextEditingController();

signMeUp() {
  if (_formKey.currentState.validate()) {}
}

class _LoginPageState extends State<LoginPage> {
  bool _success;
  String _userEmail;

  setUsername() async {
    await HelperFunction.saveUsername(controllerUsername.text);
  }

  setEmail() async {
    await HelperFunction.saveUserEmail(controllerUsername.text);
  }

  getUsername() async {
    await HelperFunction.getUsername(controllerUsername.text);
  }

  getEmail() async {
    await HelperFunction.getUserEmail(controllerUsername.text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.green, brightness: Brightness.light),
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(
                  top: 50,
                  left: 30,
                ),
                child: Text("Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 8, 30, 2.5),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email must not be blank';
                          }
                          return null;
                        },
                        decoration: textFieldDecoration("Email", "Input Email"),
                        controller: controllerEmail,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 8, 30, 2.5),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password must not be blank';
                          } else if (value.length < 8) {
                            return 'Passwort must at least 8 character long';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration:
                            textFieldDecoration("Password", "Input Password"),
                        controller: controllerPassword,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 20, 30, 50),
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white),
                        color: Colors.white12),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            _register();
                          }
                        },
                        splashColor: Colors.white60,
                        borderRadius: BorderRadius.circular(50),
                        child: Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPage();
                          }));
                        },
                        child: Text("Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration(String label, String hint) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[200], width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 3)),
      hintText: hint,
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.grey[300]),
      labelText: label,
      fillColor: Colors.white12,
      filled: true,
      prefixStyle: TextStyle(color: Colors.white),
    );
  }

  void _register() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: controllerEmail.text,
      password: controllerPassword.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(
                  top: 50,
                  left: 30,
                ),
                child: Text("Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 5, 30, 2.5),
                      child: TextFormField(
                        decoration: textFieldDecorationSignUp(
                            "Username", "Input Username"),
                        controller: controllerUsername,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Username must not be blank';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 8, 30, 2.5),
                      child: TextFormField(
                        decoration:
                            textFieldDecorationSignUp("Email", "Input Email"),
                        controller: controllerEmail,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email must not be blank';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 8, 30, 2.5),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password must not be blank';
                          } else if (value.length < 8) {
                            return 'Passwort must at least 8 character long';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: textFieldDecorationSignUp(
                            "Password", "Input Password"),
                        controller: controllerPassword,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 20, 30, 50),
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white),
                        color: Colors.white12),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: () async {
                          await DBService.createOrDeleteUser("1",
                              name: controllerUsername.text,
                              email: controllerEmail.text,
                              password: controllerPassword.text,
                              ava:
                                  "https://www.nailseatowncouncil.gov.uk/wp-content/uploads/blank-profile-picture-973460_1280.jpg");
 
                          await AuthServices.signUp(
                              controllerEmail.text, controllerPassword.text);
                        },
                        splashColor: Colors.white60,
                        borderRadius: BorderRadius.circular(50),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: Text("Log In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration textFieldDecorationSignUp(String label, String hint) {
  
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[200], width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 3)),
      hintText: hint,
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.grey[300]),
      prefixStyle: TextStyle(color: Colors.white),
      fillColor: Colors.white12,
      filled: true,
    );
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }
}
