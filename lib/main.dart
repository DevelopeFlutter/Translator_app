// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:translachor_app/models/languages_model.dart';
import 'package:translachor_app/providers/translationProvider.dart';
import 'package:translachor_app/screens/BottomBar.dart';
import 'package:translachor_app/utilities/assets_translator.dart';
import 'package:translachor_app/utilities/colour_translator.dart';
import 'package:translachor_app/utilities/controls.dart';
import 'package:translachor_app/utilities/string_translator.dart';
import 'package:translachor_app/utilities/widgets_translachor.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:path_provider/path_provider.dart';
import 'Boxes/boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dirPath = await getApplicationDocumentsDirectory();
  Hive.init(dirPath.path);
  Hive.registerAdapter(LanguagesModelAdapter());
  var box = await Hive.openBox<LanguagesModel>('Languages');
  runApp(const MyApp());
}

double screenHeight = 0.0;
double screenWidth = 0.0;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {},
      title: 'My App',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TranslatorController _controller = Get.put(TranslatorController());

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePageBottomNavigationBar(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetTranslator.splash))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight / 7,
                  ),
                  Text(StringTranslator.splashtext1,
                      style: textDesigner(30, Colors.white, FontWeight.bold)),
                  Text(StringTranslator.splashtext2,
                      style: textDesigner(15, Colors.white, FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            Image.asset(AssetTranslator.splash2),
            SizedBox(
              height: screenHeight / 30,
            ),
            SizedBox(
              width: screenWidth * 0.8,
              child: Text(
                StringTranslator.splashtext3,
                style: textDesigner(18, Colors.black, FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            WidgetTranslator.customizedButton(
                StringTranslator.splashbuttontext, () => {})
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isRecording = true;
  String wavelength = '';
  bool speak = false;
  speakerToggle() {
    speak = !speak;
    log('$speak This is speak');
  }

  void stopSpeaking() {
    ftts.stop();
  }

  Timer? _timer;

  void startListen() async {
    const timeoutDuration = Duration(seconds: 3);
    _timer = Timer(timeoutDuration, () {
      setState(() {
        _isRecording = true;
      });
    });
  }

  void copyClipBoard(text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      text.isNotEmpty && text != null
          ? Fluttertoast.showToast(
              msg: 'Text copied to clipboard',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            )
          : null;
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'Error copying text to clipboard',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    });
  }

  final SpeechToText speech = SpeechToText();
  FlutterTts ftts = FlutterTts();

  voicefunction(content, locale) async {
    log('voice function is called');
    await ftts.setLanguage(locale);
    await ftts.speak(content);
    setState(() {});
  }

  void startListening() async {
    startListen();
    setState(() {
      _isRecording = false;
    });
    String temp = ControlTranslator.CODES[ControlTranslator.FirstdropdownIndex];
    String remove = ControlTranslator
        .CODES[ControlTranslator.FirstdropdownIndex]
        .split('-')
        .last;
    temp = temp.replaceAll('-$remove', '');
    speech.listen(
      listenFor: const Duration(seconds: 3),
      onResult: (value) {
        setState(() {
          _isRecording = value.finalResult;
        });
        controller1.text = value.recognizedWords;
      },
      localeId: temp.removeAllWhitespace,
    );
  }

  TextEditingController controller1 =
      TextEditingController(text: ControlTranslator.controllerContent);
  final translator = GoogleTranslator();
  dynamic translatedContent = '';
  bool changeIndex = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.withOpacity(0.9),
      appBar: customAppBar(() {
        log('${ControlTranslator.translatedContent}==>');
      }),
      body: Column(
        children: [
          Container(
            height: screenHeight / 12,
            width: screenWidth,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.01, right: screenWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDropDown(
                    initialvalue: ControlTranslator
                        .LANGUAGES[ControlTranslator.FirstdropdownIndex],
                    items: ControlTranslator.LANGUAGES,
                    function: (v) {
                      int index = ControlTranslator.LANGUAGES.indexOf(v);
                      ControlTranslator.FirstdropdownIndex = index;
                      setState(() {
                        ControlTranslator.LANGUAGES[
                            ControlTranslator.FirstdropdownIndex] = v;
                      });
                    },
                    locale: ControlTranslator
                        .CODES[ControlTranslator.FirstdropdownIndex]
                        .split('-')
                        .first,
                  ),
                  GestureDetector(
                      onTap: () {
                        String temp = '';
                        String temp2 = '';
                        temp = ControlTranslator
                            .LANGUAGES[ControlTranslator.FirstdropdownIndex];
                        ControlTranslator.LANGUAGES[
                            ControlTranslator
                                .FirstdropdownIndex] = ControlTranslator
                            .LANGUAGES[ControlTranslator.SeconddropdownIndex];
                        ControlTranslator.LANGUAGES[
                            ControlTranslator.SeconddropdownIndex] = temp;
                        temp2 = ControlTranslator
                            .CODES[ControlTranslator.FirstdropdownIndex];
                        ControlTranslator
                                .CODES[ControlTranslator.FirstdropdownIndex] =
                            ControlTranslator
                                .CODES[ControlTranslator.SeconddropdownIndex];
                        ControlTranslator
                                .CODES[ControlTranslator.SeconddropdownIndex] =
                            temp2;
                        setState(() {});
                      },
                      child: svgImage(AssetTranslator.IconArrowhomePage, null,
                          screenHeight / 30, screenWidth * 0.8)),
                  CustomDropDown(
                    initialvalue: ControlTranslator
                        .LANGUAGES[ControlTranslator.SeconddropdownIndex],
                    items: ControlTranslator.LANGUAGES,
                    function: (v) {
                      int index = ControlTranslator.LANGUAGES.indexOf(v);
                      ControlTranslator.SeconddropdownIndex = index;
                      setState(() {
                        ControlTranslator.LANGUAGES[
                            ControlTranslator.SeconddropdownIndex] = v;
                      });
                    },
                    locale: ControlTranslator
                        .CODES[ControlTranslator.SeconddropdownIndex]
                        .split('-')
                        .first,
                  ),
                ],
              ),
            ),
          ),
          WidgetTranslator.verticalGap(screenHeight / 70),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        HomePageCustomContainer(
                            customText('', null),
                            AssetTranslator.speakerIcon,
                            AssetTranslator.microphoneIconhomepage,
                            AssetTranslator.cancelIconhomepage,
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              controller: controller1,
                              onChanged: (v) {
                                ControlTranslator.controllerContent = v;
                                // setState(() {
                                //
                                //
                                // });
                              },
                              maxLines: 8,
                            ), () {
                          speakerToggle();
                          speak
                              ? voicefunction(
                                  ControlTranslator.controllerContent,
                                  ControlTranslator.CODES[
                                      ControlTranslator.FirstdropdownIndex])
                              : stopSpeaking();
                        }, () {
                          startListening();
                        }, () {
                          controller1.clear();
                          ControlTranslator.translatedContent = '';
                          ControlTranslator.controllerContent = '';
                          setState(() {});
                        }),
                        _isRecording
                            ? const Center()
                            : Positioned(
                                top: 130,
                                left: 50,
                                child: SizedBox(
                                  width: screenWidth * 0.7,
                                  child: MusicVisualizer(
                                    colors: [
                                      ColorTranslator.spalshbuttoncolor,
                                      Colors.black87,
                                      ColorTranslator.spalshbuttoncolor,
                                      ColorTranslator.spalshbuttoncolor,
                                    ],
                                    duration: const [900, 700, 600, 800, 500],
                                    barCount: 30,
                                  ),
                                ),
                              )
                      ],
                    ),
                    WidgetTranslator.verticalGap(screenHeight / 50),
                    HomePageCustomContainer(
                        ControlTranslator.translatedContent.toString() != ''
                            ? Text(
                                '${ControlTranslator.LANGUAGES[ControlTranslator.SeconddropdownIndex]}:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              )
                            : const SizedBox(),
                        AssetTranslator.speakerIcon,
                        '',
                        AssetTranslator.copyIconhomepage,
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SingleChildScrollView(
                              child: Text(ControlTranslator.translatedContent
                                  .toString())),
                        ),
                        () {
                          voicefunction(
                              ControlTranslator.translatedContent.toString(),
                              ControlTranslator.CODES[
                                  ControlTranslator.SeconddropdownIndex]);
                        },
                        null,
                        () {
                          copyClipBoard(
                              ControlTranslator.translatedContent.toString());
                        }),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  translateMyContent(
                      ControlTranslator.controllerContent.toString());
                  setState(() {
                    ControlTranslator.translatedContent =
                        ControlTranslator.controllerContent;
                  });
                  if (ControlTranslator.translatedContent != '' &&
                      ControlTranslator.controllerContent != '') {
                    Future.delayed(const Duration(seconds: 3))
                        .then((value) async {
                      final data = LanguagesModel(
                          ControlTranslator.controllerContent.toString(),
                          ControlTranslator.translatedContent.toString(),
                          ControlTranslator
                              .LANGUAGES[ControlTranslator.FirstdropdownIndex],
                          ControlTranslator
                              .LANGUAGES[ControlTranslator.SeconddropdownIndex],
                          ControlTranslator
                              .CODES[ControlTranslator.FirstdropdownIndex],
                          ControlTranslator
                              .CODES[ControlTranslator.SeconddropdownIndex]);
                      final box = Boxes.getData();
                      box.add(data);
                      data.save();
                    });
                  } else {
                    log('Nothing');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorTranslator.homepageBarcolor),
                  child: svgimg2(
                    AssetTranslator.up_arrow_icon_homepage,
                  ),
                ),
              ),
              // Icon(Icons.copy),
            ],
          ),
        ],
      ),
    );
  }

  translateMyContent(String input) async {
    String temp = '';
    temp = ControlTranslator.CODES[ControlTranslator.SeconddropdownIndex]
        .replaceAll(' ', '');
    String remove = ControlTranslator
        .CODES[ControlTranslator.SeconddropdownIndex]
        .split('-')
        .last;
    if (temp.contains('zh')) {
      temp = temp.toLowerCase();
    } else {
      temp = temp.replaceAll('-$remove', '');
    }
    log(temp);
    input != null && input.isNotEmpty
        ? translator.translate(input, to: temp).then((dynamic value) {
            setState(
              () {
                ControlTranslator.translatedContent = value;
              },
            );
          })
        : null;
  }
}
