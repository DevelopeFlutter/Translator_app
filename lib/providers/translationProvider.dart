// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:developer';
import 'package:flutter_tts/flutter_tts.dart';
import '../languages.dart';
import '../utilities/controls.dart';
import 'package:get/get.dart';

class TranslatorController extends GetxController {
  FlutterTts ftts = FlutterTts();
  final SpeechToText speech = SpeechToText();
  List<LocaleName> _localeNames = [];
  final bool _logEvents = false;
  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
      onError: speech.errorListener,
      onStatus: speech.statusListener,
      debugLogging: _logEvents,
    );

  }
  TranslatorController(){
    initSpeechState();
    ControlTranslator.LANGUAGES.clear();
    ftts.getLanguages.then((value) {
      List temp = [];
      temp.addAll(value);
      List temp2  = [];
      temp2=temp..sort();
      List temp3 = LanguageList.langs..sort();
      ControlTranslator.LANGUAGES.clear();
      for (int i = 0; i < temp2.toString().split(',').length; i++) {
        String a = temp2.toString().split(',')[i];
        for (var element in temp3) {
          if (a.split('-').first.contains(element.split('-').first)) {
            ControlTranslator.LANGUAGES.add(element.split('-').last);
            ControlTranslator.CODES
                .add(a.replaceAll("[", '').replaceAll(']', ''));

          }
        }
      }
      // ControlTranslator.LANGUAGES = ControlTranslator.LANGUAGES..sort();
      // log('${ControlTranslator.LANGUAGES} Languages');
      // log('${ControlTranslator.CODES} CODES');
      // ControlTranslator.CODES = ControlTranslator.CODES..sort();
    });
    ftts.getVoices.then(
      (values) {

      },
    );
  }
}
