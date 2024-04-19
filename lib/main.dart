import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Scohlar());
}

class Scohlar extends StatelessWidget {
  const Scohlar({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.id:(context) => LoginScreen(),
        RegisterScreen.id:(context) => RegisterScreen(),
        ChatScreen.id:(context) => ChatScreen()
      },
      initialRoute: LoginScreen.id,
    );
  }
}

