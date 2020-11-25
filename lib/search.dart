import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/db.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  QuerySnapshot searchSnapshot;

  TextEditingController searchController = TextEditingController();

  Widget showListView() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.docs.length,
            itemBuilder: (context, index) {
              return userTile(
                searchSnapshot.docs[index].data()["nama"],
                searchSnapshot.docs[index].data()["email"],
                searchSnapshot.docs[index].data()["ava"],
              );
            })
        : Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 50,
                                height: 50,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                        image: NetworkImage(document['ava'])))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document['nama'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  document['email'],
                                  style: TextStyle(
                                      color: Colors.lightBlue, fontSize: 16),
                                )
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(24)),
                                child: Text(
                                  "Message",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          );
  }

// Text(document['nama'])
  initiateSearch() async {
    await DBService.getByUsername(searchController.text).then((value) {
      value != null
          ? setState(() {
              searchSnapshot = value;
            })
          : Text(
              "No user found",
              style: TextStyle(color: Colors.black),
            );
    });
  }

  // create chat room, send user to conversation screen push replacement
  createChatRoomAndStartConv(String username) async {

    
    List<String> user = [
      username,
    ];
    await DBService.createChatRoom("chatRoomID", "chatRoomMap");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search User"),
          backgroundColor: Colors.green,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      width: 100,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: "Search username ",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(50),
                            )),
                        controller: searchController,
                      ),
                    )),
                    GestureDetector(
                        onTap: () async {
                          await initiateSearch();
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
              StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('user').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        color: Colors.red[300],
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Text(
                          "No user found",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return showListView();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget userTile(String nama, String email, String image) {
  return Container(

    child: Row(
      children: [
        Container(
            margin: EdgeInsets.only(right: 10),
            width: 50,
            height: 50,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(image: NetworkImage(image)))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              email,
              style: TextStyle(color: Colors.lightBlue, fontSize: 16),
            )
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(24)),
            child: Text(
              "Message",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        )
      ],
    ),
  );
}
