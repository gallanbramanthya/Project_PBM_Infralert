import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infralert/service/auth_service.dart';
import 'package:infralert/common/styles.dart';
import 'package:infralert/ui/login/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthService authService = AuthService();
  bool _obsecurePassword = true;
  bool _obsecurConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteBase,
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/logo3.png',
              width: 120,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/bg_signup.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 5,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Daftar',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: whiteBase,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              WidgetTextField(
                                title: 'Email :',
                                controller: authService.email,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              WidgetTextField(
                                title: 'Nama Lengkap :',
                                controller: authService.name,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              WidgetTextField(
                                title: 'Password :',
                                controller: authService.password,
                                isPassword: true,
                                obscureText: _obsecurePassword,
                                toggleObscureText: () {
                                  setState(() {
                                    _obsecurePassword = !_obsecurePassword;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              WidgetTextField(
                                title: 'Confirm Password :',
                                controller: authService.confirmPassword,
                                isPassword: true,
                                obscureText: _obsecurConfirmPassword,
                                toggleObscureText: () {
                                  setState(() {
                                    _obsecurConfirmPassword =
                                        !_obsecurConfirmPassword;
                                  });
                                },
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
                                        color: primaryLighter,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 2,
                                        decorationColor: primaryLighter,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (authService.email != "" &&
                                      authService.password != "" &&
                                      authService.name != "") {
                                    authService.registerUser(context);
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    // width: 130,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 8),
                                    color: primaryLight,
                                    child: Text(
                                      'Daftar',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: whiteBase,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Atau daftar menggunakan',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: whiteBase,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/line.png',
                                    height: 38,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        AuthService().signInWithGoogle(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 12),
                                      child: Image.asset(
                                        'assets/images/google.png',
                                        width: 38,
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/line.png',
                                    height: 38,
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

class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    super.key,
    required this.title,
    required this.controller,
    this.isPassword = false,
    this.obscureText,
    this.toggleObscureText,
  });

  final String title;
  final TextEditingController controller;
  final bool isPassword;
  final bool? obscureText;
  final VoidCallback? toggleObscureText;

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
              color: whiteBase,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: blackBase.withOpacity(
                      0.5,
                    ),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                obscureText: isPassword ? obscureText ?? true : false,
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
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: Icon(
                            obscureText ?? true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: primaryLight,
                          ),
                          onPressed: toggleObscureText,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
