import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maily/Dimensions.dart';
import 'package:maily/screens/utils.dart';

import 'package:maily/screens/login.dart';
import 'package:maily/screens/FirstPage.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passController1 = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController2 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ref = FirebaseDatabase.instance.ref('Users'); //Pas sure

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
          margin: EdgeInsets.symmetric(vertical: Dimensions.height30),
          child: Column(
            children: [
              Hero(
                  tag: 'logo',
                  child: Image.asset(
                    "assets/logo.png",
                    width: Dimensions.width120,
                  )),
              Hero(
                  tag: 'mailyText',
                  child: Image.asset(
                    "assets/MAILY_text.png",
                    width: Dimensions.width120,
                  )),
            ],
          ),
        ),
        Hero(
          tag: 'login',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.height30),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(top: Dimensions.height220),
            padding: EdgeInsets.only(top: Dimensions.height30),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Material(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create new account',
                        style: TextStyle(
                            fontSize: Dimensions.height20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: Dimensions.width25, top: Dimensions.height15),
                        child: Text('E-mail',
                            style: TextStyle(
                                fontSize: Dimensions.height17,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20,
                            vertical: Dimensions.height5),
                        child: TextFormField(
                          controller: _emailController,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: Dimensions.width25, top: Dimensions.height15),
                        child: Text('Phone number',
                            style: TextStyle(
                                fontSize: Dimensions.height17,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width20,
                              vertical: Dimensions.height5),
                          child: IntlPhoneField(
                            controller: _phoneController,
                            initialCountryCode: AutofillHints.countryCode,
                            cursorColor: const Color.fromARGB(255, 226, 98, 39),
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
                              hintText: 'Phone number...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.height12)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                            ),
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: Dimensions.width25, top: Dimensions.height20),
                        child: Text('Password',
                            style: TextStyle(
                                fontSize: Dimensions.height17,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20,
                            vertical: Dimensions.height5),
                        child: TextFormField(
                          controller: _passController1,
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
                                  signUp(); //
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min 6 characters'
                                  : null,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height24,
                            bottom: Dimensions.height28),
                        child: TextField(
                          controller: _passController2,
                          cursorColor: const Color.fromARGB(255, 226, 98, 39),
                          obscureText: hide,
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
                            hintText: 'Confirm password...',
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: Dimensions.width60,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 213, 110, 59),
                                  fixedSize: Size(
                                      Dimensions.width70, Dimensions.height70),
                                  elevation: Dimensions.height24,
                                  shadowColor:
                                      const Color.fromARGB(255, 213, 110, 59),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.height50),
                                      side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 226, 98, 39),
                                          width: 2)),
                                ),
                                onPressed: () {
                                  signUp();
                                },
                                child: const Icon(Icons.check)),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => const Login(),
                                      transition: Transition.noTransition,
                                      duration: const Duration(seconds: 1));
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: Dimensions.height17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(children: [
            SizedBox(
              height: Dimensions.height220,
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

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    if (_passController1.text.trim() != _passController2.text.trim()) {
      Utils.showSnackBar(
          'Password and confirmation password do not match. Please try again.');
      _passController1.clear();
      _passController2.clear();
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController1.text.trim(),
        )
            .then((value) {
          ref.child(value.user!.uid.toString()).set({
            'uid': value.user!.uid.toString(),
            'userName': '',
            'email': value.user!.email.toString(),
            'phone': _phoneController.text.trim(),
            'profilPicture': '',
          });
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        Utils.showSnackBar(e.message);
      }
    }
  }
}
