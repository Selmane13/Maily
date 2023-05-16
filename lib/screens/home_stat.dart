import 'dart:ffi' hide Size;
import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maily/Dimensions.dart';
import 'package:maily/screens/dashboard.dart';

import 'package:maily/screens/login.dart';
import 'package:maily/screens/statistiques.dart';

class homeStat extends StatefulWidget {
  late int slect11;
  homeStat({super.key, required this.slect11});

  @override
  State<homeStat> createState() => _homeStatState();
}

class _homeStatState extends State<homeStat> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return getBody(widget.slect11);
  }

  Widget getBody(int slect) {
    switch (slect) {
      case 0:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: Dimensions.height350,
                height: Dimensions.height55,
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: Row(children: [
                  Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.height15,
                      ),
                      child: Text(
                        "Statistics",
                        style: TextStyle(
                            fontSize: Dimensions.height17,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: Dimensions.height200,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.height10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: Dimensions.height20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: Dimensions.height35)),
                      menuList: [
                        PopupMenuItem(
                            onTap: () {
                              setState(() {
                                widget.slect11 = 5;
                              });
                            },
                            child: item(
                              txt: "All statistics",
                            )),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 4;
                            });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 3;
                            });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 2;
                            });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 1;
                            });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: Dimensions.height60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe26127),
                        fixedSize:
                            Size(Dimensions.height100, Dimensions.height100),
                        elevation: Dimensions.height24,
                        shadowColor: Color(0xffe26127),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.height30),
                            side: const BorderSide(
                                color: Color(0xffe26127), width: 2)),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.slect11 = 1;
                        });
                      },
                      child: Text(
                        "Daily",
                        style: TextStyle(fontSize: Dimensions.height17),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe26127),
                        fixedSize:
                            Size(Dimensions.height100, Dimensions.height100),
                        elevation: Dimensions.height24,
                        shadowColor: Color(0xffe26127),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.height30),
                            side: const BorderSide(
                                color: Color(0xffe26127), width: 2)),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.slect11 = 2;
                        });
                      },
                      child: Text(
                        "Weekly",
                        style: TextStyle(fontSize: Dimensions.height17),
                      )),
                ],
              ),
              SizedBox(
                height: Dimensions.height50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe26127),
                        fixedSize:
                            Size(Dimensions.height100, Dimensions.height100),
                        elevation: Dimensions.height24,
                        shadowColor: Color(0xffe26127),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.height30),
                            side: const BorderSide(
                                color: Color(0xffe26127), width: 2)),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.slect11 = 3;
                        });
                      },
                      child: Text(
                        "Monthly",
                        style: TextStyle(fontSize: Dimensions.height17),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffe26127),
                        fixedSize:
                            Size(Dimensions.height100, Dimensions.height100),
                        elevation: Dimensions.height24,
                        shadowColor: Color(0xffe26127),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.height30),
                            side: const BorderSide(
                                color: Color(0xffe26127), width: 2)),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.slect11 = 4;
                        });
                      },
                      child: Text(
                        "Yearly",
                        style: TextStyle(fontSize: Dimensions.height17),
                      )),
                ],
              ),
              SizedBox(height: Dimensions.height60),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(Dimensions.height280, Dimensions.height60),
                    elevation: Dimensions.height24,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.height20),
                        side: const BorderSide(color: Colors.white, width: 2)),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.slect11 = 5;
                    });
                  },
                  child: Text(
                    'All statistics',
                    style: TextStyle(
                        fontSize: Dimensions.height17,
                        color: Color(0xffe26127)),
                  ))
            ],
          );
        }
      case 1:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(Dimensions.height10),
                ),
                width: Dimensions.height350,
                height: Dimensions.height55,
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: Row(children: [
                  Container(
                      child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: Dimensions.height24,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                      child: Text(
                    "Daily Statistics",
                    style: TextStyle(
                        fontSize: Dimensions.height17,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    width: Dimensions.height120,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.height10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: Dimensions.height20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: Dimensions.height35)),
                      menuList: [
                        PopupMenuItem(
                            onTap: () {
                              setState(() {
                                widget.slect11 = 5;
                              });
                            },
                            child: item(
                              txt: "All statistics",
                            )),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 4;
                            });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 3;
                            });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 2;
                            });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 1;
                            });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: Dimensions.height60,
              ),
              Statistiques(
                slc: 1,
              ),
            ],
          );
        }
      case 2:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(Dimensions.height10),
                ),
                width: Dimensions.height350,
                height: Dimensions.height55,
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: Row(children: [
                  Container(
                      child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: Dimensions.height24,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                      child: Text(
                    "Weekly Statistics",
                    style: TextStyle(
                        fontSize: Dimensions.height17,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    width: Dimensions.height100,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.height10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: Dimensions.height20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: Dimensions.height35)),
                      menuList: [
                        PopupMenuItem(
                            onTap: () {
                              setState(() {
                                widget.slect11 = 5;
                              });
                            },
                            child: item(
                              txt: "All statistics",
                            )),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 4;
                            });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 3;
                            });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 2;
                            });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 1;
                            });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: Dimensions.height60,
              ),
              Statistiques(
                slc: 2,
              ),
            ],
          );
        }
      case 3:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(Dimensions.height10),
                ),
                width: Dimensions.height350,
                height: Dimensions.height55,
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: Row(children: [
                  Container(
                      child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: Dimensions.height24,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                      child: Text(
                    "Monthly Statistics",
                    style: TextStyle(
                        fontSize: Dimensions.height17,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    width: Dimensions.height90,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.height10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: Dimensions.height20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: Dimensions.height35)),
                      menuList: [
                        PopupMenuItem(
                            onTap: () {
                              setState(() {
                                widget.slect11 = 5;
                              });
                            },
                            child: item(
                              txt: "All statistics",
                            )),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 4;
                            });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 3;
                            });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 2;
                            });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 1;
                            });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: Dimensions.height60,
              ),
              Statistiques(
                slc: 3,
              ),
            ],
          );
        }
      case 4:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(Dimensions.height10),
                ),
                width: Dimensions.height350,
                height: Dimensions.height55,
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: Row(children: [
                  Container(
                      child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: Dimensions.height24,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                      child: Text(
                    "Yearly Statistics",
                    style: TextStyle(
                        fontSize: Dimensions.height17,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    width: Dimensions.height100,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.height10),
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: Dimensions.height20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: Dimensions.height35)),
                      menuList: [
                        PopupMenuItem(
                            onTap: () {
                              setState(() {
                                widget.slect11 = 5;
                              });
                            },
                            child: item(
                              txt: "All statistics",
                            )),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 4;
                            });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 3;
                            });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 2;
                            });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 1;
                            });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: Dimensions.height60,
              ),
              Statistiques(
                slc: 4,
              ),
            ],
          );
        }
      case 5:
        {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(Dimensions.height10),
                ),
                width: Dimensions.height350,
                height: Dimensions.height55,
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: Row(children: [
                  Container(
                      child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: Dimensions.height24,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.slect11 = 0;
                      });
                    },
                  )),
                  Container(
                      child: Text(
                    "Statistics",
                    style: TextStyle(
                        fontSize: Dimensions.height17,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    width: Dimensions.height170,
                  ),
                  Container(
                    child: PopupMenu(
                      icon: Container(
                          margin: EdgeInsets.only(right: Dimensions.height20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: Dimensions.height35)),
                      menuList: [
                        PopupMenuItem(
                            onTap: () {
                              setState(() {
                                widget.slect11 = 5;
                              });
                            },
                            child: item(
                              txt: "All statistics",
                            )),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 4;
                            });
                          },
                          child: item(
                            txt: "Yearly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 3;
                            });
                          },
                          child: item(
                            txt: "Monthly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 2;
                            });
                          },
                          child: item(
                            txt: "Weekly statistics",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              widget.slect11 = 1;
                            });
                          },
                          child: item(
                            txt: "Daily statistics",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: Dimensions.height60,
              ),
              Statistiques(
                slc: 5,
              ),
            ],
          );
        }
      default:
        {
          return Container();
        }
    }
  }
}

class item extends StatelessWidget {
  final String txt;

  const item({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.height20),
          Text(txt),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.height15),
      ),
      height: Dimensions.height50,
      width: Dimensions.height200,
    );
  }
}
