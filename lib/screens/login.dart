import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maily/Dimensions.dart';
import 'package:maily/screens/FirstPage.dart';
import 'package:maily/screens/SignUp.dart';
import 'package:maily/screens/dashboard.dart';
import 'package:maily/screens/utils.dart';

import 'dart:ui';
import 'package:get/get.dart';

import 'SignUPappel.dart';
import 'forgotPasswordPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  Icon icon = const Icon(
    Icons.visibility_off,
    color: Colors.black,
  );
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Image.asset(
              "assets/back.png",
              fit: BoxFit.cover,
            )),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: const SizedBox(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Hero(tag: 'logo', child: Image.asset("assets/logo.png")),
              Hero(
                  tag: 'mailyText',
                  child: Image.asset("assets/MAILY_text.png")),
            ],
          ),
        ),
        Hero(
          tag: 'login',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(top: Dimensions.height320),
            padding: EdgeInsets.only(top: Dimensions.height30),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter to your account',
                      style: TextStyle(
                          fontSize: Dimensions.height20,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          left: Dimensions.width26, top: Dimensions.height15),
                      child: Text('E-mail',
                          style: TextStyle(
                              fontSize: Dimensions.height17,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height5),
                      child: TextField(
                        controller: _controller1,
                        cursorColor: const Color.fromARGB(255, 226, 98, 39),
                        style: TextStyle(
                          fontSize: Dimensions.height14,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.height12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.height12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: 'Enter your E-mail...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.height12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          left: Dimensions.width26, top: Dimensions.height20),
                      child: Text('Password',
                          style: TextStyle(
                              fontSize: Dimensions.height17,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height5),
                      child: TextField(
                        controller: _controller2,
                        cursorColor: const Color.fromARGB(255, 226, 98, 39),
                        obscureText: hide,
                        style: TextStyle(
                          fontSize: Dimensions.height14,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hide = !hide;
                                  icon = hide
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                        );
                                });
                                signIn();
                              },
                              icon: icon),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.height12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.height12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: 'Enter your password...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.height12)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                          right: Dimensions.width20, top: Dimensions.height10),
                      child: GestureDetector(
                        child: Text(
                          'Forgot the password ?',
                          style: TextStyle(
                              fontSize: Dimensions.height14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 213, 110, 59),
                          fixedSize:
                              Size(Dimensions.width300, Dimensions.height55),
                          elevation: Dimensions.height24,
                          shadowColor: const Color.fromARGB(255, 213, 110, 59),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height24),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 226, 98, 39),
                                  width: 2)),
                        ),
                        onPressed: signIn,
                        child: const Text('Log in to Maily')),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const Inscription(),
                              transition: Transition.noTransition,
                              duration: const Duration(seconds: 1));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: Dimensions.height17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(children: [
            SizedBox(
              height: Dimensions.height330,
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                Get.to(() => const FirstPage(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1));
                ;
              },
              child: Image.asset(
                'assets/line.png',
                width: Dimensions.height200,
              ),
            ),
          ]),
        )
      ]),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controller1.text.trim(), password: _controller2.text.trim());
      Get.to(() => const Dashboard(),
          transition: Transition.noTransition,
          duration: const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    // navig
  }
}
