// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:translachor_app/utilities/controls.dart';
import 'package:translachor_app/utilities/widgets_translachor.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:translachor_app/Boxes/boxes.dart';
import 'package:translachor_app/main.dart';
import 'package:translachor_app/models/languages_model.dart';
import 'package:translachor_app/utilities/widgets_translachor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utilities/colour_translator.dart';
import '../utilities/string_translator.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  TextEditingController textFieldController = TextEditingController();
  ControlTranslator ForIndex = ControlTranslator();
  void retrieveIndexes() async {
    var indexBox = await Hive.openBox<int>('indexBox');

    List<int> indexes = [];
    for (var index in indexBox.values) {
      indexes.add(index);
      log('${index}These are the index');
    }
  }


    @override
    void initState() {
    retrieveIndexes();
      super.initState();
    }
    @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: customAppBar(() {}),
          body: ValueListenableBuilder<Box<LanguagesModel>>(
              builder: (context, box, _) {
                var data = box.values.toList().cast<LanguagesModel>();
                return Column(
                  children: [
                    customSearchContainer(textFieldController,
                        StringTranslator.FaoritetextFieldText),
                    SizedBox(
                      height: screenHeight / 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 20,
                        ),
                        child:
                             ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: ControlTranslator.Index,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.4,
                                        child: Row(
                                          children: [
                                            WidgetTranslator
                                                .homePageCustomContainer(
                                                ColorTranslator
                                                    .homepageBarcolor,
                                                data[ControlTranslator
                                                    .Index]
                                                    .locale1
                                                    .split('-')
                                                    .first
                                                    .toString()),
                                            SizedBox(
                                              width: screenWidth * 0.01,
                                            ),
                                            Text(data[
                                            ControlTranslator.Index]
                                                .language1
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.4,
                                        child: Row(
                                          children: [
                                            WidgetTranslator
                                                .homePageCustomContainer(
                                                ColorTranslator
                                                    .homepageBarcolor,
                                                data[ControlTranslator
                                                    .Index]
                                                    .locale2
                                                    .split('-')
                                                    .first
                                                    .toString()),
                                            SizedBox(
                                              width: screenWidth * 0.01,
                                            ),
                                            Text(data[
                                            ControlTranslator.Index]
                                                .language2
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: Border()),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 7.5,
                                                vertical: 7.5),
                                            width: screenWidth * 0.4,
                                            child: Text(data[
                                            ControlTranslator.Index]
                                                .content1
                                                .toString())),
                                        Container(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 7.5,
                                                vertical: 7.5),
                                            width: screenWidth * 0.4,
                                            child: Text(data[
                                            ControlTranslator.Index]
                                                .content2
                                                .toString())),
                                        const Icon(Icons.star),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                            //);
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
              valueListenable: Boxes.getData().listenable()));
    }
  }
