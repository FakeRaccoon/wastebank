import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastebank/Home.dart';
import 'package:wastebank/main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future logout() async {
    await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser.uid).update({
      "active": false,
    });
    await FirebaseAuth.instance.signOut().whenComplete(() => Get.offAll(() => Root()));
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(auth.currentUser.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['role'] == 'member' || snapshot.data['role'] == 'superuser') {
              return Home();
            }
            if (snapshot.data['role'] == 'new user') {
              return Center(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(10),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'Hi ${snapshot.data['name']}, selamat datang di bank sampah. Silahkan lengkapi data diri anda :)'),
                        SizedBox(height: 10),
                        TextButton(onPressed: () {}, child: Text('Lanjutkan')),
                        TextButton(onPressed: logout, child: Text('Logout'))
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data['name']),
                  TextButton(onPressed: logout, child: Text('Log out')),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
