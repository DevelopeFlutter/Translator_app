// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:translachor_app/utilities/assets_translator.dart';
import 'package:translachor_app/utilities/colour_translator.dart';
import 'package:translachor_app/utilities/string_translator.dart';
import 'package:translachor_app/utilities/widgets_translachor.dart';
import '../main.dart';
import 'Favorite.dart';
import 'History.dart';
class HomePageBottomNavigationBar extends StatefulWidget {
  const HomePageBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<HomePageBottomNavigationBar> createState() => _HomePageBottomNavigationBarState();
}

class _HomePageBottomNavigationBarState extends State<HomePageBottomNavigationBar> {
  final List _Pages = <Widget>[const MyHomePage(), const History(), const Favorite()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customAppBar(),
      resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
      showSelectedLabels: false,
      // type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        customBottomNavBaritmes(
            (_selectedIndex == 0)
                ? ColorTranslator.homepageBarcolor
                : Colors.transparent,
            AssetTranslator.bottomBarhomeIcon,
            StringTranslator.Bottombariconstext1,
            screenHeight / 20,
            screenWidth * 0.3,
            (_selectedIndex == 0)
                ? Colors.white
                : ColorTranslator.homepageBarcolor.withOpacity(0.30),
            textDesigner(
                14,
                _selectedIndex == 0
                    ? Colors.white
                    : ColorTranslator.homepageBarcolor.withOpacity(0.30),
                FontWeight.normal)),
        customBottomNavBaritmes(
            (_selectedIndex == 1)
                ? ColorTranslator.homepageBarcolor
                : Colors.transparent,
            AssetTranslator.bottomBarhistoryIcon,
            StringTranslator.Bottombariconstext2,
            screenHeight / 20,
            screenWidth * 0.3,
            (_selectedIndex == 1)
                ? Colors.white
                : ColorTranslator.homepageBarcolor.withOpacity(0.30),
            textDesigner(
                14,
                _selectedIndex == 1
                    ? Colors.white
                    : ColorTranslator.homepageBarcolor.withOpacity(0.30),
                FontWeight.normal)),
        customBottomNavBaritmes(
            (_selectedIndex == 2)
                ? ColorTranslator.homepageBarcolor
                : Colors.transparent,
            AssetTranslator.bottomBarfavoriteIcon,
            StringTranslator.Bottombariconstext3,
            screenHeight / 20,
            screenWidth * 0.3,
            (_selectedIndex == 2)
                ? Colors.white
                : ColorTranslator.homepageBarcolor.withOpacity(0.30),
            textDesigner(
                14,
                _selectedIndex == 2
                    ? Colors.white
                    : ColorTranslator.homepageBarcolor.withOpacity(0.30),
                FontWeight.normal)),
      ],
      currentIndex: _selectedIndex,
      // selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    ),
      body:_Pages.elementAt(_selectedIndex),
    );
  }
}
