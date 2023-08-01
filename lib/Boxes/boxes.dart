// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';

import '../models/languages_model.dart';

class Boxes {
  static Box<LanguagesModel> getData() => Hive.box<LanguagesModel>('Languages');
}
