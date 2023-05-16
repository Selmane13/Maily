import 'dart:ffi' hide Size;
import 'dart:io';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:maily/Dimensions.dart';
import 'package:maily/screens/login.dart';
import 'package:maily/screens/utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool opened = true;
  String data1 = "Mail";
  String? data;
  final _emailController = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String imageURL = "";

  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /*UPDATE PROFILE PICTURE*/
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  /// ******
  final ref = FirebaseDatabase.instance.ref('Users');
  final ref2 = FirebaseDatabase.instance.ref('Users');
  final user = FirebaseAuth.instance.currentUser!;

  int _selctedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final r = FirebaseDatabase.instance.ref('ouverte');

    r.get().then(
      (snap) {
        opened = snap.value.toString() == "true";
      },
    );
    /* ref2.child(user.uid.toString()).get().then((snap) {
                   Map<dynamic, dynamic> map2 = snap.value as dynamic;
                    List<dynamic> list2 = [];
                  list2.clear();
                  list2 = map2.values.toList();
                  print(Text(list2[3]['Time']));
                  } 
                  );*/
    switch (_selctedIndex) {
      case 0:
        return StreamBuilder(
            stream: ref.child(user.uid.toString()).onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  return Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 233, 233, 233),
                    ),
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: Dimensions.height120,
                            width: Dimensions.height120,
                            margin: EdgeInsets.only(top: Dimensions.height20),
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 233, 233, 233),
                                // child: Image.asset(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.height300),
                                    child: (image == null &&
                                            map['profilPicture'].toString() ==
                                                "")
                                        ? Icon(
                                            Icons.person,
                                            size: Dimensions.height35,
                                          )
                                        : Image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                map['profilPicture']
                                                    .toString()),
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                            errorBuilder:
                                                (context, error, stack) {
                                              return Container(
                                                child: const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.redAccent,
                                                ),
                                              );
                                            },
                                          )),
                              ),
                            ),
                          ),
                          /* SizedBox(
                            height: Dimensions.height15,
                          ),
                          Container(
                              child: Text(
                            "HOCINE Mohamed",
                            style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 3.0,
                                    color: Colors.grey.withOpacity(0.6),
                                  ),
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 8.0,
                                    color: Colors.grey.withOpacity(0.6),
                                  ),
                                ],
                                fontSize: Dimensions.height24,
                                fontWeight: FontWeight.bold),
                          )),*/
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.height20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height20),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                /*  */

                                ListTile(
                                  leading: Image.asset("assets/Telicon.png"),
                                  title: Text('+213 ' + map['phone']),
                                  trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selctedIndex = 1;
                                        });
                                      },
                                      child:
                                          Image.asset("assets/modifyicon.png")),
                                ),
                                //),
                                Container(
                                  width: Dimensions.height220,
                                  child: const Divider(
                                    thickness: 0.7,
                                    color: Colors.black,
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset("assets/mailicon.png"),
                                  title: Text(map['email']),
                                  trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selctedIndex = 2;
                                        });
                                      },
                                      child:
                                          Image.asset("assets/modifyicon.png")),
                                ),
                                Container(
                                  width: Dimensions.height220,
                                  child: const Divider(
                                    thickness: 0.7,
                                    color: Colors.black,
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset("assets/photoicon.png"),
                                  title: const Text("Edit picture"),
                                  trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selctedIndex = 3;
                                        });
                                      },
                                      child:
                                          Image.asset("assets/modifyicon.png")),
                                ),
                                Container(
                                  width: Dimensions.height220,
                                  child: const Divider(
                                    thickness: 0.7,
                                    color: Colors.black,
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset("assets/@icon.png"),
                                  title: const Text("Set username"),
                                  trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selctedIndex = 4;
                                        });
                                      },
                                      child:
                                          Image.asset("assets/modifyicon.png")),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.height20,
                                vertical: Dimensions.height20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height20),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selctedIndex = 5;
                                    });
                                  },
                                  child: ListTile(
                                    leading:
                                        Image.asset("assets/savedicon.png"),
                                    title: const Text("Saved Mails"),
                                  ),
                                ),
                                Container(
                                  width: Dimensions.height220,
                                  child: const Divider(
                                    thickness: 0.7,
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selctedIndex = 6;
                                    });
                                  },
                                  child: ListTile(
                                    leading: Image.asset(
                                      "assets/premium.png",
                                    ),
                                    title: const Text("Maily Premium"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height20),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      !opened ? Colors.red : Colors.green,
                                  fixedSize: Size(Dimensions.height220,
                                      Dimensions.height50),
                                  elevation: Dimensions.height24,
                                  shadowColor:
                                      !opened ? Colors.red : Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.height24),
                                      side: BorderSide(
                                          color: !opened
                                              ? Colors.red
                                              : Colors.green,
                                          width: 2)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    r.set(true);
                                  });
                                },
                                child: !opened
                                    ? const Text('Open the mail box')
                                    : const Text('The mail box is opened')),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height20),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  fixedSize: Size(Dimensions.height220,
                                      Dimensions.height50),
                                  elevation: Dimensions.height24,
                                  shadowColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.height24),
                                      side: const BorderSide(
                                          color: Colors.red, width: 2)),
                                ),
                                onPressed: () {
                                  Get.to(() => const Login(),
                                      transition: Transition.noTransition,
                                      duration: const Duration(seconds: 1));
                                  FirebaseAuth.instance.signOut();
                                },
                                child: const Text('Log out')),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
      case 1:
        return Column(children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.height20),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: Dimensions.height24,
                    ),
                    onPressed: () {
                      setState(() {
                        _selctedIndex = 0;
                      });
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.height10),
                  child: Text("Phone number",
                      style: TextStyle(
                          fontSize: Dimensions.height20,
                          fontWeight: FontWeight.bold)))
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.height20,
                  vertical: Dimensions.height40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.height12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: IntlPhoneField(
                  initialCountryCode: AutofillHints.countryCode,
                  controller: _phoneController,
                  cursorColor: const Color.fromARGB(255, 226, 98, 39),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.height12)),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    hintText: 'Phone number...',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: Dimensions.height40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE26127),
              fixedSize: Size(Dimensions.height165, Dimensions.height40),
              elevation: Dimensions.height24,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.height24),
                  side: const BorderSide(color: Color(0xFFE26127))),
            ),
            onPressed: () {
              //modifier num
              ref.child(user.uid.toString()).update({
                'phone': _phoneController.text.trim(),
              }).then((value) {
                _phoneController.clear();
              });

              setState(() {
                _selctedIndex = 0;
              });
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]);
      case 2:
        return Form(
          key: formKey,
          child: Column(children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height20, left: Dimensions.height20),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: Dimensions.height24,
                      ),
                      onPressed: () {
                        setState(() {
                          _selctedIndex = 0;
                        });
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height20, left: Dimensions.height10),
                    child: Text("Mail address",
                        style: TextStyle(
                            fontSize: Dimensions.height20,
                            fontWeight: FontWeight.bold)))
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.height20,
                  vertical: Dimensions.height40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.height12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextFormField(
                controller: _emailController,
                cursorColor: const Color.fromARGB(255, 226, 98, 39),
                style: TextStyle(
                  fontSize: Dimensions.height14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.height12)),
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.height12)),
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                  ),
                  hintText: 'Mail address',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.height12)),
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
            ),
            SizedBox(
              height: Dimensions.height40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE26127),
                fixedSize: Size(Dimensions.height165, Dimensions.height40),
                elevation: Dimensions.height24,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.height24),
                    side: const BorderSide(color: Color(0xFFE26127))),
              ),
              onPressed: () {
                setState(() {
                  //save email
                  savEmail();

                  _selctedIndex = 0;
                });
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        );
      case 3:
        return Container(
          color: const Color.fromARGB(255, 233, 233, 233),
          width: double.maxFinite,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height20,
                            left: Dimensions.height20),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            size: Dimensions.height24,
                          ),
                          onPressed: () {
                            setState(() {
                              _selctedIndex = 0;
                            });
                          },
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height20,
                            left: Dimensions.height10),
                        child: Text("Picture",
                            style: TextStyle(
                                fontSize: Dimensions.height20,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
                /* Container(
                  height: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 40),
                ),*/

                SizedBox(
                  height: Dimensions.height20,
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height80),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize:
                          Size(Dimensions.height300, Dimensions.height60),
                      elevation: Dimensions.height24,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.height24),
                          side: const BorderSide(color: Colors.white)),
                    ),
                    onPressed: () {
                      pickGalleryImage(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            size: Dimensions.height35),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        const Text(
                          'Choose from library',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize:
                          Size(Dimensions.height300, Dimensions.height60),
                      elevation: Dimensions.height24,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.height24),
                          side: const BorderSide(color: Colors.white)),
                    ),
                    onPressed: () {
                      pickCameraImage(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt,
                            color: Colors.black, size: Dimensions.height35),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        const Text(
                          'Take a photo',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize:
                          Size(Dimensions.height300, Dimensions.height60),
                      elevation: Dimensions.height24,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.height24),
                          side: const BorderSide(color: Colors.white)),
                    ),
                    onPressed: () {
                      ref
                          .child(user.uid.toString())
                          .update({'profilPicture': ""}).then((value) {
                        Utils.showSnackBargray('Profile picture removed');
                        _image = null;
                      }).onError((error, stackTrace) {
                        Utils.showSnackBar(error.toString());
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.delete,
                            color: Colors.red, size: Dimensions.height35),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        const Text(
                          'Remove current picture',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE26127),
                    fixedSize: Size(Dimensions.height165, Dimensions.height40),
                    elevation: Dimensions.height24,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.height24),
                        side: const BorderSide(color: Color(0xFFE26127))),
                  ),
                  onPressed: () {
                    setState(() {
                      //save picture
                      _selctedIndex = 0;
                    });
                  },
                  child: const Text(
                    'Edit picture',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      case 4:
        return Column(children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.height20),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: Dimensions.height24,
                    ),
                    onPressed: () {
                      setState(() {
                        _selctedIndex = 0;
                      });
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.height10),
                  child: Text("Username",
                      style: TextStyle(
                          fontSize: Dimensions.height20,
                          fontWeight: FontWeight.bold)))
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.height12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.height20, vertical: Dimensions.height40),
            child: Container(
              child: TextFormField(
                controller: _usernameController,
                cursorColor: const Color.fromARGB(255, 226, 98, 39),
                style: TextStyle(
                  fontSize: Dimensions.height14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.height12)),
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.height12)),
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                  ),
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.height12)),
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 226, 98, 39),
              fixedSize: Size(Dimensions.height165, Dimensions.height40),
              elevation: Dimensions.height24,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.height24),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 226, 98, 39))),
            ),
            onPressed: () {
              //modifier username
              ref.child(user.uid.toString()).update({
                'userName': _usernameController.text.trim(),
              }).then((value) {
                _usernameController.clear();
              });
              setState(() {
                _selctedIndex = 0;
              });
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]);
      case 5:
        return Container(
          margin: EdgeInsets.only(left: Dimensions.height20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: Dimensions.height24,
                      ),
                      onPressed: () {
                        setState(() {
                          _selctedIndex = 0;
                        });
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height20, left: Dimensions.height10),
                    child: Text("Saved mails",
                        style: TextStyle(
                            fontSize: Dimensions.height20,
                            fontWeight: FontWeight.bold)))
              ],
            ),
            SizedBox(
              height: Dimensions.height40,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      right: Dimensions.height20, bottom: Dimensions.height10),
                  child: Container(
                    width: Dimensions.height350,
                    height: Dimensions.height100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.height30),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height12,
                                        left: Dimensions.height17),
                                    child: Icon(Icons.circle,
                                        color: Colors.white,
                                        size: Dimensions.height20),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.height12,
                                        left: Dimensions.height5),
                                    child: Text(
                                      data1,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: Dimensions.height17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height5,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.height12,
                                  left: Dimensions.height40),
                              child: Text(
                                //list[index]['Date'],
                                "On: 03/05/2023",
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: Dimensions.height17),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: Dimensions.height170,
                                  left: Dimensions.height40),
                              child: Text(
                                //list[index]['Time'],
                                "At: 05:16",
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: Dimensions.height17),
                              ),
                            )
                          ],
                        ),
                        /**** */

                        Container(
                            width: Dimensions.height28,
                            child: Image.asset("assets/save.png")),
                      ],
                    ),
                  ),
                );
              },
            )
          ]),
        );
      case 6:
        return Column(children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.height20),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: Dimensions.height24,
                    ),
                    onPressed: () {
                      setState(() {
                        _selctedIndex = 0;
                      });
                    },
                  )),
              Container(
                margin: EdgeInsets.only(top: Dimensions.height30),
                child: Container(child: Image.asset("assets/MailyPremium.png")),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.height20,
                right: Dimensions.height20,
                top: Dimensions.height30),
            child: Container(
              width: Dimensions.height350,
              height: Dimensions.height400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.height30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.height12,
                              left: Dimensions.height17),
                          child: Icon(Icons.circle,
                              color: Colors.white, size: Dimensions.height20),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Dimensions.height12),
                          child: Text(
                            "Get your Boxes here",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: Dimensions.height28),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height5,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height12, left: Dimensions.height20),
                    child: Text(
                      "       Maily Premium is a version of Maily which the user can get all the mails and boxes here on this application .",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          height: Dimensions.height1p5,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: Dimensions.height17),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height40, left: Dimensions.height40),
                    child: Text(
                      //list[index]['Time'],
                      "Feachers : \n      -\n      -\n      -\n",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: Dimensions.height17),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Image.asset("assets/boxPremium.png")),
                ],
              ),
            ),
          )
        ]);
      default:
        return Container();
    }
  }

  void savEmail() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await user.updateEmail(_emailController.text.trim());
      ref.child(user.uid.toString()).update({
        'email': _emailController.text.trim(),
      }).then((value) {
        _phoneController.clear();
      });
      Utils.showSnackBargray('Email updated!');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
    }
  }

  void uploadImage(BuildContext context) async {
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + user.uid.toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path));
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    ref
        .child(user.uid.toString())
        .update({'profilPicture': newUrl.toString()}).then((value) {
      Utils.showSnackBargray('Profile picture updated');
      _image = null;
    }).onError((error, stackTrace) {
      Utils.showSnackBar(error.toString());
    });
  }
}
