// ignore_for_file: depend_on_referenced_packages
import 'package:hive/hive.dart';
part 'languages_model.g.dart';

@HiveType(typeId: 0)
class LanguagesModel extends HiveObject {
  @HiveField(0)
  String content1;
  @HiveField(1)
  String content2;
  @HiveField(2)
  String language1;
  @HiveField(3)
  String language2;
  @HiveField(4)
  String locale1;
  @HiveField(5)
  String locale2;
  LanguagesModel(this.content1, this.content2, this.language1, this.language2,
      this.locale1, this.locale2);
}
