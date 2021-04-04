import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashapp/constants.dart';
import 'package:flashapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashapp/components/rounded_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';


  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String fName;
  String lName;
  String phoneNumber;
  final _firestore = FirebaseFirestore.instance;

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
                    margin: EdgeInsets.only(bottom: 30.0),
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
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  fName = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your First Name',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  lName = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Last Name',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              IntlPhoneField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Phone Number',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
                onChanged: (phone) {
                  phoneNumber = phone.completeNumber;
                  print(phoneNumber);
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  btnHolder: 'Register',
                  colour: Colors.blueAccent,
                  onPressed:  () async
              {
                setState(() {
                  showSpinner = true;
                });
                try {
                UserCredential newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password
                );
                    _firestore.collection('UserData').add({
                  'email': _auth.currentUser.email,
                  'fName':  fName,
                  'lName': lName,
                  'phoneNumber' : phoneNumber,
                });


                if(newUser != null)
                  {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                setState(() {
                  showSpinner = false;
                });
              } on FirebaseAuthException catch (e) {
                  if(e.code == 'weak=password'){
                    print('The password provided is too weak.');
                  } else if(e.code == 'email-already-in-use'){
                    print('The account already exists for the email.');
                  }
                }
              catch (e) {
                print(e);
              }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
