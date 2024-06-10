import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:infralert/common/styles.dart';
import 'package:infralert/ui/bottom_navbar/bottom_navbar.dart';
import 'package:infralert/ui/login/login_page.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  void loginUser(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      await auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                print("User berhasil login"),
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavBar(),
                  ),
                  (route) => false,
                ),
              });
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: whiteBase,
            title: Text(
              "Pesan Error",
              style: GoogleFonts.poppins(
                color: redBase,
              ),
            ),
            content: Text(
              'Terdapat kesalahan. Silahkan cek kembali email dan password anda!',
              style: GoogleFonts.poppins(
                color: redBase,
              ),
            ),
          );
        },
      );
    }
  }

  void registerUser(BuildContext context) async {
    if (password.text != confirmPassword.text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: whiteBase,
            title: Text(
              "Pesan Error",
              style: GoogleFonts.poppins(
                color: redBase,
              ),
            ),
            content: Text(
              'Password dan Konfirmasi Password tidak cocok!',
              style: GoogleFonts.poppins(
                color: redBase,
              ),
            ),
          );
        },
      );
      return;
    }

    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      final userUid = userCredential.user?.uid;

      if (userUid != null) {
        await firestore.collection('users').doc(userUid).set(
          {
            'email': email.text,
            'password': password.text,
            'uid': userUid,
            'name': name.text,
            'createdAt': Timestamp.now(),
            'phoneNUmber': '-',
            'city': '-',
          },
        );

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: whiteBase,
            title: Text(
              "Pesan Error",
              style: GoogleFonts.poppins(
                color: redBase,
              ),
            ),
            content: Text(
              'Pastikan isi semua data diri anda',
              style: GoogleFonts.poppins(
                color: redBase,
              ),
            ),
          );
        },
      );
    }
  }

  signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void logOutUser(context) async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (route) => false,
    );
  }
}
