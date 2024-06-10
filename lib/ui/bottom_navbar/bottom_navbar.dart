import 'package:flutter/material.dart';
import 'package:infralert/common/styles.dart';
import 'package:infralert/ui/bottom_navbar/history_page.dart';
import 'package:infralert/ui/bottom_navbar/home_page.dart';
import 'package:infralert/ui/bottom_navbar/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar(
      {super.key, this.initialIndex = 1}); // Default index is 1 for home

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  final List<String> unselectedIcons = [
    'assets/images/history_outline.png',
    'assets/images/home_outline.png',
    'assets/images/profile_outline.png',
  ];
  final List<String> selectedIcons = [
    'assets/images/history_filled.png',
    'assets/images/home_filled.png',
    'assets/images/profile_filled.png',
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _onItemTapped(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightest,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomAppBar(
          color: whiteBase,
          height: 60,
          surfaceTintColor: whiteBase,
          shape: CircularNotchedRectangle(),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                unselectedIcons.length,
                (index) => Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      _onItemTapped(index);
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: ImageIcon(
                        _selectedIndex == index
                            ? AssetImage(selectedIcons[index])
                            : AssetImage(unselectedIcons[index]),
                        color: _selectedIndex == index
                            ? blackBase
                            : blackBase.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget currentScreen = MyHomePage();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          currentScreen = HistoryPage();
          break;
        case 1:
          currentScreen = MyHomePage();
          break;
        case 2:
          currentScreen = ProfilePage();
          break;
      }
    });
  }
}
