import 'package:chat_app/components/custome_button.dart';
import 'package:chat_app/components/custome_textfield.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constans.dart';
import '../helper/snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Spacer(
                  flex: 3,
                ),
                Image.asset("assets/images/scholar.png"),
                Text(
                  "Scohlar Chat",
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                Spacer(
                  flex: 2,
                ),
                Row(
                  children: [
                    Text(
                      "REGISTER",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomeTextField(
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'email is required';
                    } else if (data.contains('@') == false) {
                      return 'email is not valid';
                    }
                  },
                  hintText: 'Email',
                  onChange: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomeTextField(
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'password is required';
                      } else if (data.length < 7) {
                        return 'password is too short';
                      }
                    },
                    onChange: (value) {
                      password = value;
                    },
                    hintText: 'Password'),
                const SizedBox(
                  height: 20,
                ),
                CustomeButton(
                  text: 'REGISTER',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await createUser();
                        Navigator.pushNamed(context, ChatScreen.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "weak_password") {
                          snackBarMessage(context, "your password is weak");
                        } else if (e.code == "email-already-in-use") {
                          snackBarMessage(context, "email is already in use");
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don\'t have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
