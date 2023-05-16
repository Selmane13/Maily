import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maily/Dimensions.dart';
import 'package:maily/screens/sqflitetest.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseDatabase.instance.ref('mails');
  final _textcontroller = TextEditingController();
  String data = "New mails";
  String data1 = " New mail";
  bool saved = false;
  bool read = false;
  int _selectedIndex = 0;
  List<Mail> _mails = [];
  String? date;
  String? heure;
  String? selectedJ = "01";
  String? selected = "2019";
  String? selectedM = "01";
  String? selectedJ2 = "01";
  String? selected2 = "2023";
  String? selectedM2 = "01";
  @override
  void initState() {
    super.initState();
    selected = "2019";
    selectedM = "01";
    selected2 = "2023";
    selectedM2 = "01";
    selectedJ2 = "01";
    selectedJ = "01";
    BDDLocale.init().then((_) {
      BDDLocale.getMails().then((mails) {
        setState(() {
          _mails = mails;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> listItems = ["2019", "2020", "2022", "2023"];
    List<String> listItemsM = [
      "01",
      "02",
      "03",
      "04",
      "05",
      "06",
      "07",
      "08",
      "09",
      "10",
      "11",
      "12"
    ];
    List<String> listItemsJ = [
      "01",
      "02",
      "03",
      "04",
      "05",
      "06",
      "07",
      "08",
      "09",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20",
      "21",
      "22",
      "23",
      "24",
      "25",
      "26",
      "27",
      "28",
      "29",
      "30",
      "31"
    ];

    switch (_selectedIndex) {
      case 0:
        return Container(
          margin: EdgeInsets.only(left: Dimensions.width17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimensions.height20,
              ),
              Container(
                width: Dimensions.width350,
                height: Dimensions.height55,
                margin: EdgeInsets.only(right: Dimensions.width15),
                child: Row(children: [
                  Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width15,
                      ),
                      child: Text(
                        data,
                        style: TextStyle(
                            fontSize: Dimensions.height17,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: Dimensions.width180,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width10),
                    child: PopupMenuButton(
                      padding: EdgeInsets.only(right: Dimensions.width20),
                      icon: Container(
                          margin: EdgeInsets.only(right: Dimensions.width20),
                          child: Icon(Icons.menu,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: Dimensions.height35)),
                      color: Color(0xffB4B4B4),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 2;
                            });
                          },
                          child: item(
                            icon: Icons.search,
                            txt: "search For mail",
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              read = true;
                            });
                          },
                          child: item(
                            icon: Icons.mark_email_read,
                            txt: "Make mails as read",
                          ),
                        ),
                        PopupMenuItem(
                          child: item(
                            icon: Icons.cleaning_services_sharp,
                            txt: "Clear all mails",
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4),
                  borderRadius: BorderRadius.circular(Dimensions.height10),
                ),
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                read = true;
                                _selectedIndex = 1;
                                date = list[index]['Date'];
                                heure = list[index]['Time'];
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: Dimensions.width20,
                                  bottom: Dimensions.height10),
                              child: Container(
                                width: Dimensions.width350,
                                height: Dimensions.height100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.height30),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: Dimensions.height12,
                                                    left: Dimensions.width16),
                                                child: Icon(Icons.circle,
                                                    color: read
                                                        ? Color.fromARGB(
                                                            255, 255, 255, 255)
                                                        : Color(0xFFE26127),
                                                    size: Dimensions.height20),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: Dimensions.height12,
                                                    left: Dimensions.width5),
                                                child: read
                                                    ? Text(
                                                        "Mail",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontSize: Dimensions
                                                                .height17),
                                                      )
                                                    : Text(
                                                        data1,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontSize: Dimensions
                                                                .height17),
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
                                              top: Dimensions.height17,
                                              left: Dimensions.width40),
                                          child: Text(
                                            list[index]['Date'],
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: Dimensions.height17),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: Dimensions.width170,
                                              left: Dimensions.width40),
                                          child: Text(
                                            list[index]['Time'],
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: Dimensions.height17),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: Dimensions.width20,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            saved = !saved;
                                          });
                                        },
                                        child: Container(
                                            width: Dimensions.width28,
                                            child: saved
                                                ? Image.asset("assets/save.png")
                                                : Image.asset(
                                                    "assets/nosave.png"))),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      //Doit retourner un widget
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffe26127),
                        ),
                      );
                    }
                  })
            ],
          ),
        );

      case 1:
        return Column(children: [
          SizedBox(
            height: Dimensions.height60,
          ),
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height30),
            child: Container(
              width: Dimensions.width350,
              height: Dimensions.height400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.height30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.height20,
                              left: Dimensions.width20),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              size: Dimensions.height24,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 0;
                              });
                            },
                          )),
                      Container(
                        margin: EdgeInsets.only(top: Dimensions.height30),
                        child: Container(
                            child: Image.asset("assets/mail_details.png")),
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.height12,
                              left: Dimensions.width16),
                          child: Icon(Icons.circle,
                              color: Colors.white, size: Dimensions.height20),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          child: Text(
                            "\nHello,",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: Dimensions.height20),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width40),
                    child: Text(
                      "\n\n     You’ve recived a new mail in Your mail box. \nTime: at " +
                          heure! +
                          " \n           on " +
                          date!,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          height: 1.5,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: Dimensions.height17),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]);

      case 2:
        {
          return Container(
            margin: EdgeInsets.only(left: Dimensions.width17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimensions.height20,
                ),
                Container(
                  width: Dimensions.width350,
                  height: Dimensions.height55,
                  margin: EdgeInsets.only(right: Dimensions.width15),
                  child: Row(children: [
                    Container(
                        child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: Dimensions.height24,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                    )),
                    Container(
                        margin: EdgeInsets.only(
                          left: 2,
                        ),
                        child: Text(
                          "Search For mail",
                          style: TextStyle(
                              fontSize: Dimensions.height17,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      width: Dimensions.width110,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width10),
                      child: PopupMenuButton(
                        padding: EdgeInsets.only(right: Dimensions.width20),
                        icon: Container(
                            margin: EdgeInsets.only(right: Dimensions.width20),
                            child: Icon(Icons.menu,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: Dimensions.height35)),
                        color: Color(0xffB4B4B4),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 2;
                              });
                            },
                            child: item(
                              icon: Icons.search,
                              txt: "search For mail",
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              setState(() {
                                read = true;
                              });
                            },
                            child: item(
                              icon: Icons.mark_email_read,
                              txt: "Make mails as read",
                            ),
                          ),
                          PopupMenuItem(
                            child: item(
                              icon: Icons.cleaning_services_sharp,
                              txt: "Clear all mails",
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  decoration: BoxDecoration(
                    color: Color(0xffB4B4B4),
                    borderRadius: BorderRadius.circular(Dimensions.height10),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height30,
                ),
                Row(
                  children: [
                    Text(
                      "From : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Dimensions.height24),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width5, right: Dimensions.width5),
                      height: Dimensions.height40,
                      width: Dimensions.width60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height10),
                      ),
                      margin: EdgeInsets.only(left: Dimensions.width5),
                      child: DropdownButton<String>(
                        value: selectedJ,
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        items: listItemsJ
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        onChanged: ((item) => setState(() => selectedJ = item)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width5, right: Dimensions.width5),
                      height: Dimensions.height40,
                      width: Dimensions.width120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height10),
                      ),
                      margin: EdgeInsets.only(left: Dimensions.width5),
                      child: DropdownButton<String>(
                        value: selectedM,
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        items: listItemsM
                            .map((item1) => DropdownMenuItem(
                                value: item1, child: Text(item1)))
                            .toList(),
                        onChanged: ((item1) =>
                            setState(() => selectedM = item1)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width5, right: Dimensions.width5),
                      height: Dimensions.height40,
                      width: Dimensions.width80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height10),
                      ),
                      margin: EdgeInsets.only(left: Dimensions.width5),
                      child: DropdownButton<String>(
                        value: selected,
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        items: listItems
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        onChanged: ((item) => setState(() => selected = item)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  children: [
                    Text(
                      "To : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Dimensions.height24),
                    ),
                    SizedBox(
                      width: Dimensions.width26,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width5, right: Dimensions.width5),
                      height: Dimensions.height40,
                      width: Dimensions.width60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height10),
                      ),
                      margin: EdgeInsets.only(left: Dimensions.width5),
                      child: DropdownButton<String>(
                        value: selectedJ2,
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        items: listItemsJ
                            .map((item1) => DropdownMenuItem(
                                value: item1, child: Text(item1)))
                            .toList(),
                        onChanged: ((item1) =>
                            setState(() => selectedJ2 = item1)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width5, right: Dimensions.width5),
                      height: Dimensions.height40,
                      width: Dimensions.width120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height10),
                      ),
                      margin: EdgeInsets.only(left: Dimensions.width5),
                      child: DropdownButton<String>(
                        value: selectedM2,
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        items: listItemsM
                            .map((item1) => DropdownMenuItem(
                                value: item1, child: Text(item1)))
                            .toList(),
                        onChanged: ((item1) =>
                            setState(() => selectedM2 = item1)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width5, right: Dimensions.width5),
                      height: Dimensions.height40,
                      width: Dimensions.width80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height10),
                      ),
                      margin: EdgeInsets.only(left: Dimensions.width5),
                      child: DropdownButton<String>(
                        value: selected2,
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        items: listItems
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        onChanged: ((item) => setState(() => selected2 = item)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Container(
                  width: Dimensions.width300,
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                SingleChildScrollView(
                  child: StreamBuilder(
                      stream: (FirebaseDatabase.instance
                              .ref('mails')
                              .orderByChild('Date2')
                              .startAt('$selected/$selectedM/$selectedJ')
                              .endAt('$selected2/$selectedM2/$selectedJ2'))
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.snapshot.value != null) {
                            Map<dynamic, dynamic>? map =
                                snapshot.data!.snapshot.value as dynamic;
                            List<dynamic> list = [];
                            list.clear();
                            list = map!.values.toList();

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  snapshot.data!.snapshot.children.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 1;
                                      date = list[index]['Date'];
                                      heure = list[index]['Time'];
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: Dimensions.height20,
                                        bottom: Dimensions.height10),
                                    child: Container(
                                      width: Dimensions.width350,
                                      height: Dimensions.height100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.height30),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: Dimensions
                                                              .height12,
                                                          left: Dimensions
                                                              .width16),
                                                      child: Icon(Icons.circle,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          size: Dimensions
                                                              .height20),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: Dimensions
                                                              .height12,
                                                          left: Dimensions
                                                              .width5),
                                                      child: Text(
                                                        "Mail",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontSize: Dimensions
                                                                .height17),
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
                                                    left: Dimensions.width40),
                                                child: Text(
                                                  list[index]['Date'],
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize:
                                                          Dimensions.height17),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: Dimensions.width170,
                                                    left: Dimensions.width40),
                                                child: Text(
                                                  list[index]['Time'],
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize:
                                                          Dimensions.height17),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: Dimensions.width20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return ListTile(
                              title: Text(
                                  '  no data is available within this date range'),
                            );
                          }
                        } else {
                          //Doit retourner un widget
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffe26127),
                            ),
                          );
                        }
                      }),
                )
              ],
            ),
          );
        }
      default:
        return Container();
    }
  }
}

class EssaiRealTime extends StatefulWidget {
  const EssaiRealTime({super.key});

  @override
  State<EssaiRealTime> createState() => _EssaiRealTimeState();
}

class _EssaiRealTimeState extends State<EssaiRealTime> {
  final ref = FirebaseDatabase.instance.ref('mails');
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('aa'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();

                      return ListView.builder(
                          itemCount: snapshot.data!.snapshot.children.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(list[index]['Date']),
                              subtitle: Text(list[index]['Time']),
                            );
                          });
                    } else {
                      //Doit retourner un widget
                      return ListTile(
                        title: Text('rien'),
                      );
                    }
                  }),
            ),
            /* Expanded(child: FirebaseAnimatedList(

        query: ref, 
        itemBuilder: ( (context, snapshot, animation, index)  {
        return  ListTile (
        title: Text(snapshot.child('Date').value.toString()),
        subtitle: Text(snapshot.child('Time').value.toString()),
        );

        }
        )
      )
      )*/
          ],
        ),
      );
}

class PopupMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget icon;

  const PopupMenu({Key? key, required this.menuList, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.only(right: Dimensions.width20),
      itemBuilder: (context) => menuList,
      icon: icon,
      color: Color(0xffB4B4B4),
    );
  }
}

class item extends StatelessWidget {
  final IconData icon;
  final String txt;

  const item({Key? key, required this.icon, required this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.width10,
          ),
          Icon(
            icon,
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          Text(txt),
        ],
      ),
      margin: EdgeInsets.only(top: Dimensions.height20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.height15),
      ),
      height: Dimensions.height50,
      width: Dimensions.height220,
    );
  }
}
