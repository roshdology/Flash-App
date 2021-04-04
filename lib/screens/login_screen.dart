import 'package:flashapp/components/rounded_button.dart';
import 'package:flashapp/constants.dart';
import 'package:flashapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showSpinner = false;
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'Logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                   email = value;
                },
                decoration: kTextFieldDecoration.copyWith(

                    hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                onChanged: (value) {
                    password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)

                  ),

                )
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                btnHolder: 'Log In',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async{
                  print(email);
                  print(password);
                  setState(() {
                    showSpinner = true;
                  });
                    try {
                      UserCredential userCredential = await _auth.
                      signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      User user = _auth.currentUser;
                      print(user.email);
                      if( UserCredential != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } on FirebaseAuthException catch (e){
                      if(e.code =='user-not-found'){
                        print('No use was found for that email.');
                      } else if(e.code == 'wrong-password'){
                        print('Wrong password provided for that user.');
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });

              })
            ],
          ),
        ),
      ),
    );
  }
}
