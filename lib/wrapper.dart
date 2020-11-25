import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_flutter/register_page.dart';
import 'package:whatsapp_clone_flutter/main_page.dart';
import 'package:whatsapp_clone_flutter/splash_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);
    return (firebaseUser == null) ? LoginPage() : MainPage(firebaseUser);
  }
}
