import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wastebank/main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  /// Google account login

  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future registerWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential.user.uid.isNotEmpty) {
        FirebaseFirestore.instance.collection('Users').doc(userCredential.user.uid).set({
          'email': userCredential.user.email,
          'name': nameController.text,
          'register_at': DateTime.now(),
          'role': 'new user',
        });
        Get.to(() => Root());
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        print('password weak');
      } else if (e.code == "email-already-in-use") {
        print('email used');
      } else if (e.code == 'invalid-email') {
        print('please enter correct email format');
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Nama'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            TextButton(
              onPressed: () => registerWithEmailAndPassword(),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
