import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      backgroundColor: Colors.lightGreen,
                      expandedHeight: MediaQuery.of(context).size.height * .50,
                      automaticallyImplyLeading: false,
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go Green',
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text('Waste bank'),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.person),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )
              ];
            },
            body: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(top: 1, left: 0, right: 0, child: Icon(Icons.remove, size: 30)),
                  ListView(
                    children: [
                      Text('Feature', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 20)),
                      Card(
                        child: Column(
                          children: [
                            Text('Jenis Sampah', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
