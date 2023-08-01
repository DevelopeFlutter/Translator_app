// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use, must_be_immutable, avoid_types_as_parameter_names

import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translachor_app/main.dart';
import 'package:translachor_app/utilities/string_translator.dart';
import 'assets_translator.dart';
import 'colour_translator.dart';
import 'controls.dart';
import 'package:translator/translator.dart';

textDesigner(double size, color, weight) {
  return GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: size, fontWeight: weight, color: color));
}

class WidgetTranslator {
  static customizedButton(String str, Function() func,
      {Color buttonColor = const Color(0xff2929BB),
      Color textColor = const Color(0xFFFFFFFF),
      bool clickAble = true}) {
    return ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        fixedSize: (Size(screenWidth, screenHeight / 15)),
        backgroundColor:
            (clickAble) ? ColorTranslator.spalshbuttoncolor : Colors.white,
      ),
      child: Text(
        str,
        style: textDesigner(16, Colors.white, FontWeight.bold),
      ),
    );
  }

  static homePageCustomContainer(
    color,
    text,
  ) {
    return Container(
      height: screenHeight / 35,
      width: screenWidth * 0.09,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          style: textDesigner(
            14,
            Colors.white,
            FontWeight.normal,
          ),
        ),
      ),
    );
  }

  static verticalGap(double size) {
    return SizedBox(
      height: size,
    );
  }
}

class CustomDropDown extends StatefulWidget {
  CustomDropDown(
      {Key? key,
      required this.initialvalue,
      required this.items,
      required this.function,
      required this.locale})
      : super(key: key);
  String initialvalue = '';
  List<String> items = [];
  dynamic function;
  String locale;
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final translator = GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WidgetTranslator.homePageCustomContainer(
            ColorTranslator.homepageBarcolor, widget.locale),
        SizedBox(
          width: screenWidth * 0.001,
        ),
        PopupMenuButton<String>(
          itemBuilder: (context) {
            return widget.items.map((str) {
              return PopupMenuItem(
                value: str,
                child: Text(str),
              );
            }).toList();
          },
          onSelected: widget.function,
          child: Row(
            children: <Widget>[
              customText(widget.initialvalue,
                  textDesigner(12, Colors.black, FontWeight.bold)),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        )
      ],
    );
  }
}

horizontalGap(double size) {
  return SizedBox(
    width: size,
  );
}

HomePageCustomContainer(
  widget,
  speakerIcon,
  bottomIcon1,
  bottomIcon2,
  Widget,
  onTapSpeaker,
  speechOnTap,
  closeAndCopyOnTap,
) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: [
        // bottomIcon1 == ''
        //     ?
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(children: [widget]),
        ),
        // : const SizedBox(),
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05, top: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: screenWidth - 130,
                  height: screenHeight / 4.2,
                  child: Widget),
              Padding(
                  padding: EdgeInsets.only(
                      top: screenWidth * 0.03, left: screenWidth * 0.09),
                  child: GestureDetector(
                      onTap: onTapSpeaker,
                      child:
                      // (play)
                      //     ? const Icon(Icons.stop)
                      //     :
                      svgimg2(speakerIcon))),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.04),
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight / 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: speechOnTap,
                    child: bottomIcon1 == AssetTranslator.microphoneIconhomepage
                        ? svgimg2(
                            bottomIcon1,
                          )
                        : const Text('')),
                horizontalGap(screenWidth * 0.04),
                GestureDetector(
                    onTap: closeAndCopyOnTap,
                    child: svgimg2(
                      bottomIcon2,
                    )),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

customBottomNavBaritmes(color, img, text, height, width, imgcolor, textStyle) {
  return BottomNavigationBarItem(
      icon: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20))
            // shape: BoxShape.circle
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgImage(img, imgcolor, null, null),
            horizontalGap(screenWidth * 0.03),
            customText(text, textStyle)
          ],
        ),
      ),
      label: '');
}

customText(text, style) {
  return Text(
    text,
    style: style,
  );
}

assetImage(imgpath) {
  return Image.asset(
    imgpath,
    scale: 0.7,
  );
}

svgimg2(img) {
  return SvgPicture.asset(
    img,
  );
}

customSearchContainer(controller, text) {
  return Container(
    margin: EdgeInsets.only(
        left: screenWidth * 0.08,
        right: screenWidth * 0.12,
        top: screenHeight / 35),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(3)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListTile(
        leading: const Icon(Icons.search),
        title: TextField(
            controller: controller,
            decoration:
                InputDecoration(hintText: text, border: InputBorder.none),
            onChanged: (value) {}
            // onSearchTextChanged,
            ),
        trailing: IconButton(
          icon: const Icon(Icons.mic),
          onPressed: () {
            controller.clear();
            // onSearchTextChanged('');
          },
        ),
      ),
    ),
  );
}

svgImage(picture, color, height, width) {
  return SvgPicture.asset(
    picture,
    color: color,
    height: height,
    width: width,
  );
}

customAppBar(onTap){
  return AppBar(
      backgroundColor: ColorTranslator.homepageBarcolor,
      title: Center(
          child: Text(
        StringTranslator.homepageBartext,
        style: textDesigner(
            20, ColorTranslator.homepageBartextcolor, FontWeight.normal),
      )),
      leading: Transform.scale(
          scale: 0.4,
          child: GestureDetector(
              onTap: onTap,
              child: svgImage(AssetTranslator.homepageMenuIcon, null,
                  screenHeight / 60, screenWidth * 0.9))));
}
