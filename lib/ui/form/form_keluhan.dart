import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infralert/common/styles.dart';

class FormKeluhan extends StatefulWidget {
  const FormKeluhan({super.key});

  @override
  State<FormKeluhan> createState() => _FormKeluhanState();
}

class _FormKeluhanState extends State<FormKeluhan> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedCondition;
  File? image;
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteBase,
          title: Text(
            'Sumber Gambar',
            style: GoogleFonts.poppins(
              color: primaryBase,
            ),
          ),
          content: Text(
            'Pilih sumber gambar',
            style: GoogleFonts.poppins(
              color: primaryBase,
            ),
          ),
          actions: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text(
                'Galeri',
                style: GoogleFonts.poppins(
                  color: primaryBase,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  setState(() => image = File(pickedImage.path));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text(
                'Kamera',
                style: GoogleFonts.poppins(
                  color: primaryBase,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  setState(() => image = File(pickedImage.path));
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> submitForm() async {
    if (titleController.text.isEmpty ||
        complaintController.text.isEmpty ||
        locationController.text.isEmpty ||
        selectedCondition == null ||
        image == null ||
        currentUser == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: whiteBase,
            title: Center(
              child: Text(
                'Peringatan!',
                style: GoogleFonts.poppins(
                  color: redBase,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Text(
              'Silakan isi semua kolom dan pilih gambar',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: redBase,
                fontSize: 14,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(
                      color: primaryBase,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('form_keluhan')
          .add({
        'title': titleController.text,
        'complaint': complaintController.text,
        'location': locationController.text,
        'condition': selectedCondition,
        'timestamp': Timestamp.now(),
        'status': 'Dalam proses',
        'category': 'Jalan',
        'imageLink':
            'https://firebasestorage.googleapis.com/v0/b/infralert-9193c.appspot.com/o/form%2Fkeluhan_jalan.png?alt=media&token=b084016c-1c99-4c3f-89d7-3bbd5ba2a956',
      });

      titleController.clear();
      complaintController.clear();
      locationController.clear();
      setState(() {
        selectedCondition = null;
        image = null;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Sukses',
              style: GoogleFonts.poppins(
                color: primaryBase,
              ),
            ),
            content: Text(
              'Form berhasil dikirim',
              style: GoogleFonts.poppins(
                color: primaryBase,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Gagal submit form: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteBase,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              backgroundColor: whiteBase,
              leading: SizedBox(),
              leadingWidth: 0.0,
              expandedHeight: 240,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                titlePadding: EdgeInsets.all(30),
                centerTitle: true,
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                background: Container(
                  color: whiteBase,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/bg_form.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          height: 30,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: primaryLightest,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(50),
                              ),
                              border: Border.all(
                                color: whiteBase,
                                width: 0,
                              )),
                        ),
                        bottom: -1,
                        left: 0,
                        right: 0,
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: whiteBase,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                  color: blackBase.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Text(
                              "Selamat Datang di menu Lapor Keluhan, Anda dapat melaporkan tentang infrastruktur yang rusak atau tidak berfungsi normal, harap isi form dengan benar ya!",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 80,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/arrow_back.png',
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Container(
                  color: primaryLightest,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Form Keluhan Jalan',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      WidgetTextField(
                        title: 'Judul',
                        hintText: 'e. g. Jalan Berlubang',
                        controller: titleController,
                      ),
                      SizedBox(height: 12),
                      WidgetTextField(
                        title: 'Keluhan',
                        hintText: 'e. g. Membahayakan Pengguna Jalan',
                        controller: complaintController,
                      ),
                      CustomDropdownExample(
                        onConditionSelected: (condition) {
                          setState(() {
                            selectedCondition = condition;
                          });
                        },
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Gambar/Bukti',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: pickImage,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryBase,
                                    boxShadow: [
                                      BoxShadow(
                                        color: blackBase.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    'Pilih gambar dari galeri...',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: whiteBase,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (image != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    image!,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      WidgetTextField(
                        title: 'Lokasi',
                        hintText: 'e. g. Jl. PB Sudirman (Depan Gereja GPIB)',
                        controller: locationController,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: submitForm,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 130,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              color: greenBase,
                              child: Center(
                                child: Text(
                                  'Submit',
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
                      ),
                      SizedBox(height: 50),
                    ],
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

class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: blackBase.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: whiteBase,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownExample extends StatefulWidget {
  final void Function(String?) onConditionSelected;

  const CustomDropdownExample({
    Key? key,
    required this.onConditionSelected,
  }) : super(key: key);

  @override
  State<CustomDropdownExample> createState() => _CustomDropdownExampleState();
}

class _CustomDropdownExampleState extends State<CustomDropdownExample> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            'Kondisi',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: blackBase.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              decoration: InputDecoration(
                fillColor: primaryBase,
                filled: true,
                hintText: 'Pilih tingkat kerusakan fasilitas/infrastruktur',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: whiteBase,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: primaryBase,
              icon: Icon(
                Icons.arrow_drop_down,
                color: whiteBase,
              ),
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: whiteBase,
                fontWeight: FontWeight.w500,
              ),
              items: ['Rusak Ringan', 'Rusak Parah'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                  widget.onConditionSelected(newValue);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
