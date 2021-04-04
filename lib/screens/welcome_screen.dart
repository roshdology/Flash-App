import 'package:flashapp/screens/login_screen.dart';
import 'package:flashapp/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashapp/components/rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  
  AnimationController controller;
  Animation animation;
  
  @override
  void initState()  {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("Initialized successfully !");
      setState(() {
      });
    });
    controller =
        AnimationController(duration: Duration(seconds: 1 ), vsync: this,);

    animation =
        ColorTween(begin:Colors.blueGrey, end: Colors.white).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});

    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'Logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),

                 SizedBox(
                   child: DefaultTextStyle(style: TextStyle(
                     fontSize: 45.0,
                     fontWeight: FontWeight.w900,
                     color: Colors.black,
                   ),

                   child: AnimatedTextKit
                     (
                     animatedTexts: [
                       TypewriterAnimatedText('Flash Chat'),
                     ],
                   ),
                ),
                 ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              btnHolder: 'Log In',
              onPressed:() {
              Navigator.pushNamed(context, LoginScreen.id);

            },
              colour: Colors.lightBlueAccent,
            ),
            RoundedButton(
              btnHolder: 'Register',
            onPressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
            },
              colour: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}

