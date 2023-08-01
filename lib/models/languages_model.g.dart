// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguagesModelAdapter extends TypeAdapter<LanguagesModel> {
  @override
  final int typeId = 0;

  @override
  LanguagesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguagesModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LanguagesModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.content1)
      ..writeByte(1)
      ..write(obj.content2)
      ..writeByte(2)
      ..write(obj.language1)
      ..writeByte(3)
      ..write(obj.language2)
      ..writeByte(4)
      ..write(obj.locale1)
      ..writeByte(5)
      ..write(obj.locale2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguagesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
