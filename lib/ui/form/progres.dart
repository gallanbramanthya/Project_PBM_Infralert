import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infralert/common/styles.dart';

class KeluhanProgres extends StatefulWidget {
  const KeluhanProgres({super.key});

  @override
  State<KeluhanProgres> createState() => _KeluhanProgresState();
}

class _KeluhanProgresState extends State<KeluhanProgres> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBase,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 44.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/logo1.png'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 90,
                    left: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/arrow_back.png',
                        width: 22,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 55,
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
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/images/progres_indicator.png',
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          'Keluhan Nomor #8291270 · 28 April 2024',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: primaryBase,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/images/idea.png',
                          height: 199,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Dalam proses\npersiapan perbaikan...',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: primaryBase,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Keluhanmu dalam tahap persiapan untuk perbaikan, harap bersabar dan pantau terus prosesnya ya!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: primaryBase,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 170,
            left: MediaQuery.of(context).size.width / 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                color: whiteBase,
                child: Text(
                  'Seberapa jauh penindakan laporan keluhanmu dapat dilihat disini!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: primaryBase,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
