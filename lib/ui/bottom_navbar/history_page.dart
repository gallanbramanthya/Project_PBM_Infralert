import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:infralert/common/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime _dateTime = DateTime.now();
  bool _isLocaleInitialized = false;
  List<Map<String, dynamic>> _formKeluhanData = [];
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _initializeLocale();
    _fetchDataForDate(_dateTime);
  }

  Future<void> _initializeLocale() async {
    await initializeDateFormatting('id', null);
    setState(() {
      _isLocaleInitialized = true;
    });
  }

  Future<void> _fetchDataForDate(DateTime date) async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final startOfMonth = DateTime(date.year, date.month, 1);
      final endOfMonth = DateTime(date.year, date.month + 1, 0, 23, 59, 59);

      final formKeluhanSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('form_keluhan')
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
          .where('timestamp',
              isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth))
          .get();

      setState(() {
        _formKeluhanData =
            formKeluhanSnapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }

  void _showDatePicker() {
    showMonthPicker(
      backgroundColor: primaryLightest,
      headerColor: primaryBase,
      currentMonthTextColor: whiteBase,
      unselectedMonthTextColor: primaryBase,
      selectedMonthBackgroundColor: primaryBase,
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          _fetchDataForDate(_dateTime);
        });
      }
    });
  }

  String _formatDate(DateTime date) {
    if (!_isLocaleInitialized) return '';
    return DateFormat('MMMM yyyy', 'id').format(date);
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('d MMMM yyyy', 'id').format(date);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLocaleInitialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBase,
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 44.0),
                    child: Image.asset(
                      'assets/images/logo1.png',
                      width: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Riwayat Keluhan',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: whiteBase,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 27),
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 27,
                      ),
                      InkWell(
                        onTap: _showDatePicker,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 320,
                            height: 40,
                            color: whiteBase,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _formatDate(_dateTime),
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: blackBase,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      _formKeluhanData.isEmpty
                          ? Column(
                              children: [
                                Image.asset(
                                  'assets/images/history.png',
                                  height: 250,
                                ),
                                Text(
                                  'Belum ada laporan masuk',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: redBase,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: _formKeluhanData.map((keluhan) {
                                return Column(
                                  children: [
                                    CustomContainer(
                                      title: keluhan['timestamp'] != null
                                          ? _formatTimestamp(
                                              keluhan['timestamp'])
                                          : 'Unknown Date',
                                      subtitle1: keluhan['category'] ??
                                          'Unknown Category',
                                      subtitle2:
                                          keluhan['status'] ?? 'Unknown Status',
                                      imageUrl: keluhan['imageLink'] ?? '',
                                    ),
                                    SizedBox(height: 27),
                                  ],
                                );
                              }).toList(),
                            ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
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

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.imageUrl,
  });

  final String title;
  final String subtitle1;
  final String subtitle2;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        color: primaryLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: whiteBase,
                  ),
                ),
                Text(
                  'Kategori Keluhan : $subtitle1',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: whiteBase,
                  ),
                ),
                Text(
                  'Status : $subtitle2',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: whiteBase,
                  ),
                ),
              ],
            ),
            imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 35,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) {
                      print("Error loading image: $error"); // Print error
                      return Icon(Icons.error);
                    },
                  )
                : Container(
                    height: 45,
                    width: 45,
                    color: primaryLightest,
                    child: Text('Ups, belum ada laporan terekam'),
                  ),
          ],
        ),
      ),
    );
  }
}
