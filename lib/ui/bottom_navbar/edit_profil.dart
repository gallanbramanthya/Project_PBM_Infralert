import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infralert/common/styles.dart';
import 'package:infralert/ui/bottom_navbar/bottom_navbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['name'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneNumberController.text = data['phoneNumber'] ?? '';
          _cityController.text = userDoc['city'] ?? '';
        });
      }
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': _nameController.text,
          'email': _emailController.text,
          'phoneNumber': _phoneNumberController.text,
          'city': _cityController.text,
        });
        _showDialog(context, 'Sukses', 'Profil berhasil diperbaharui');
      }
    }
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteBase,
          title: Text(
            title,
            style: GoogleFonts.poppins(),
          ),
          content: Text(
            content,
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavBar(initialIndex: 2),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                  color: primaryBase,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBase,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: whiteBase,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: primaryBase,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            color: whiteBase,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            WidgetEditProfile(
              title: 'Nama',
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Silahkan masukkan nama anda";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            WidgetEditProfile(
              title: 'Email',
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Silahkan masukkan email anda";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            WidgetEditProfile(
              title: 'No telefon',
              controller: _phoneNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Silahkan masukkan nomor telefon anda";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            WidgetEditProfile(
              title: 'Kota Asal',
              controller: _cityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Silahkan masukkan kota asal anda";
                }
                return null;
              },
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: _saveProfile,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: primaryLight,
                    child: Center(
                      child: Text(
                        'Simpan',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: whiteBase,
                        ),
                      ),
                    ),
                    // width: 130,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,

                      // color: primaryLight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetEditProfile extends StatelessWidget {
  const WidgetEditProfile({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
  });

  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: blackBase,
            ),
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: blackBase.withOpacity(0.2),
                    blurRadius: 16,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                validator: validator,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: whiteBase,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryLight, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: primaryLight,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: primaryLightest,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
