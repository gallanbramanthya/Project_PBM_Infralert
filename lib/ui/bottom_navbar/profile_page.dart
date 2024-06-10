import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:infralert/common/styles.dart';
import 'package:infralert/service/auth_service.dart';
import 'package:infralert/ui/bottom_navbar/edit_profil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  File? _image;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      fetchUserData();
    });
  }

  Future<void> fetchUserData() async {
    if (currentUser != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data() as Map<String, dynamic>;
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  String formatDate(Timestamp? timestamp) {
    if (timestamp != null) {
      DateTime date = timestamp.toDate();
      return DateFormat.yMMMMd('id_ID').format(date);
    }
    return 'Tanggal';
  }

  Future<void> _pickImage() async {
    // Show dialog to choose between gallery and camera
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih sumber gambar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeri'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImageFromSource(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Kamera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImageFromSource(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null && currentUser != null) {
      try {
        // Use user's name for the image file name
        String userName = userData?['name'] ?? 'user';
        String fileName = 'profile_${userName}.jpg';
        UploadTask uploadTask = FirebaseStorage.instance
            .ref('profile_images')
            .child(fileName)
            .putFile(_image!);

        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .update({'profileImageUrl': downloadUrl});

        setState(() {
          userData?['profileImageUrl'] = downloadUrl;
        });
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBase,
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Container(
                                  width: 152,
                                  height: 152,
                                  child: userData?['profileImageUrl'] != null
                                      ? Image.network(
                                          userData!['profileImageUrl'],
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/profile.png'),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 0,
                                child: InkWell(
                                  onTap: _pickImage,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: whiteBase,
                                        boxShadow: [
                                          BoxShadow(
                                            color: blackBase.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'assets/images/camera.png',
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(
                                userData?['name'] ?? 'User Name',
                                style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: whiteBase,
                                ),
                              ),
                              Text(
                                'Bergabung sejak ${formatDate(userData?['createdAt'] as Timestamp?)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: whiteBase,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: primaryLightest,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(62),
                        topRight: Radius.circular(62),
                      ),
                    ),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomContainer(
                            text1: 'Kota Asal',
                            text2: userData?['city'] ?? '-',
                          ),
                          CustomContainer(
                            text1: 'Nomor Telefon',
                            text2: userData?['phoneNumber'] ?? '-',
                          ),
                          CustomContainer(
                            text1: 'Email',
                            text2: userData?['email'] ?? 'Email not set',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfile(),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 130,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    color: primaryLight,
                                    child: Center(
                                      child: Text(
                                        'Edit Profil',
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: whiteBase,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  AuthService authService = AuthService();
                                  authService.logOutUser(context);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 130,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    color: redBase,
                                    child: Center(
                                      child: Text(
                                        'Keluar',
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: whiteBase,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 300,
              left: 115,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  color: whiteBase,
                  child: Text(
                    'Info Pribadi',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: primaryBase,
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

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 275,
            height: 40,
            color: whiteBase,
            child: Center(
              child: Text(
                text2,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: blackLight,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
