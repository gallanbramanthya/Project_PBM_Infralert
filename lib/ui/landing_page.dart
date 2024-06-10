import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infralert/common/styles.dart';
import 'package:infralert/ui/login/login_page.dart';
import 'package:infralert/ui/login/signup_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteBase,
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/gambar1.png',
              width: 335,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/shape.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 15,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Selamat datang di \nInfrAlert !',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: whiteBase,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/logo2.png',
                                  width: 85,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Aplikasi Pemantauan Kerusakan Infrastruktur yang membantu untuk melaporakan segala kerusakan atau ketidaknormalan fungsi dari infrastruktur atau fasilitas masyarakat di bidang lalu lintas',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: whiteBase,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 8),
                                    color: whiteBase,
                                    child: Text(
                                      'Mulai',
                                      style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: primaryLight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Sudah punya akun?',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: whiteBase,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: Text(
                                      'Masuk',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: primaryLightest,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                        decorationColor: primaryLighter,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
