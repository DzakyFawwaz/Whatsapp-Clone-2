import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/auth_service.dart';
import 'package:whatsapp_clone_flutter/search.dart';

class MainPage extends StatelessWidget {
  final User user;
  MainPage(this.user);

  TabBar tabBar = TabBar(
      indicator: BoxDecoration(
        color: Colors.green,
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 5),
        ),
      ),
      tabs: [
        Tab(
          icon: Icon(Icons.camera_enhance),
        ),
        Tab(
          text: "CHAT",
        ),
        Tab(
          text: "STATUS",
        ),
        Tab(
          text: "CALLS",
        )
      ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("WhatsappClone Flutter"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }));
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await AuthServices.signOut();
              },
            ),
          ],
          bottom: tabBar,
        ),
        body: TabBarView(
          children: [
            Container(),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Data"),
                  );
                }
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 25,
                        child: Text(document['nama']),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
