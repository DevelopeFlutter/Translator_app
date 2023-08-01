// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:translachor_app/Boxes/boxes.dart';
import 'package:translachor_app/main.dart';
import 'package:translachor_app/models/languages_model.dart';
import 'package:translachor_app/utilities/widgets_translachor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utilities/colour_translator.dart';
import '../utilities/controls.dart';
import '../utilities/string_translator.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  TextEditingController controller = TextEditingController();
  bool forStarIcon = false;

  void storeIndexes(List<int> indexes) async {
    log('${indexes}Thses are the indexes');
    var box = await Hive.openBox<int>('indexBox');
    await box.addAll(indexes);
    await box.close();
  }
  void retrieveItems() async {
    var indexBox = await Hive.openBox<int>('indexBox');
    List<int> items = [];
    for (var index in indexBox.values) {
      items.add(index);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: customAppBar(() {}),
        body: ValueListenableBuilder<Box<LanguagesModel>>(
            builder: (context, box, _) {
              var data = box.values.toList().cast<LanguagesModel>();
              return Column(
                children: [
                  customSearchContainer(
                      controller, StringTranslator.HistroytextFieldText),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 20,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: box.length,
                        itemBuilder: (context, dynamic index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.5,
                                        child: Row(
                                          children: [
                                            WidgetTranslator
                                                .homePageCustomContainer(
                                                    ColorTranslator
                                                        .homepageBarcolor,
                                                    data[index]
                                                        .locale1
                                                        .split('-')
                                                        .first
                                                        .toString()),
                                            // SizedBox(
                                            //   width: screenWidth * 0.001,
                                            // ),
                                            Text(
                                                data[index]
                                                    .language1
                                                    .toString(),
                                                style: textDesigner(
                                                    12,
                                                    Colors.black,
                                                    FontWeight.bold)),
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
                                                    data[index]
                                                        .locale2
                                                        .split('-')
                                                        .first
                                                        .toString()),

                                            Text(
                                                data[index]
                                                    .language2
                                                    .toString(),
                                                style: textDesigner(
                                                    12,
                                                    Colors.black,
                                                    FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white, border: Border()),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7.5, vertical: 7.5),
                                          width: screenWidth * 0.4,
                                          child: Text(
                                              data[index].content1.toString())),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7.5, vertical: 7.5),
                                          width: screenWidth * 0.4,
                                          child: Text(
                                              data[index].content2.toString())),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              forStarIcon = true;
                                              storeIndexes(index);
                                              log('${ControlTranslator.Index} Index');
                                            });
                                          },
                                          child: const Icon(
                                            Icons.star,
                                            color:
                                                // forStarIcon
                                                //     ? ColorTranslator
                                                //         .spalshbuttoncolor
                                                //     :
                                                Colors.black,
                                          )),
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
