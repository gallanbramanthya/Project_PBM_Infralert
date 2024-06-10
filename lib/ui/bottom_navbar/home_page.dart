import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infralert/common/styles.dart';
import 'package:infralert/ui/form/form_keluhan.dart';
import 'package:infralert/ui/form/form_penerangan.dart';
import 'package:infralert/ui/form/progres.dart';
import 'package:infralert/ui/form/form_rambu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBase,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 38,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'InfrAlert',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: whiteBase,
                            ),
                          ),
                          Text(
                            'Ajukan keluhan demi kenyamanan',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: whiteBase,
                            ),
                          )
                        ],
                      ),
                      Image.asset(
                        'assets/images/logo2.png',
                        width: 85,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryLightest,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(62),
                        topRight: Radius.circular(62),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormKeluhan(),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            color: whiteBase,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 26),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/keluhan_jalan.png',
                                    width: 50,
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Keluhan Jalan',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormPenerangan(),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            color: whiteBase,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/lampu.png',
                                        width: 50,
                                      ),
                                      Image.asset(
                                        'assets/images/penerangan.png',
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Keluhan Lampu dan Penerangan',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormRambu(),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            color: whiteBase,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 26,
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/rambu.png',
                                    width: 60,
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Keluhan Rambu',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KeluhanProgres(),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            color: whiteBase,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/progres.png',
                                    width: 60,
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Progres\nKeluhan',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Text(
                        'BERITA',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final items = [
                              {
                                "image": 'assets/images/berita1.png',
                                "text":
                                    '800 Km Jalan Rusak di Jember, Perbaikan Gunakan Skema Anggaran Multi Years',
                              },
                              {
                                "image": 'assets/images/berita2.png',
                                "text":
                                    'Portal Ambruk Ditabrak Truk, Kadishub Jember: Harus Ganti, Jika Tidak Saya Lapor Polisi',
                              },
                              {
                                "image": 'assets/images/berita3.png',
                                "text":
                                    'Perbaikan Jalan di Kota Bekasi Rampung 60 Persen | Republika Online',
                              },
                            ];
                            final item = items[index];
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: whiteBase,
                                  width: 240,
                                  height: 200,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              item['image']!,
                                              height: 130,
                                              width: 240,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4.0,
                                            ),
                                            child: Text(
                                              item['text']!,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
