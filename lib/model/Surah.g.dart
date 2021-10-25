// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Surah.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahAdapter extends TypeAdapter<Surah> {
  @override
  final int typeId = 0;

  @override
  Surah read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Surah(
      number: fields[0] as int,
      arabic: fields[1] as String,
      name: fields[3] as String,
      latin: fields[2] as String,
      totalAyah: fields[4] as int,
      ayah: (fields[5] as Map)?.cast<String, dynamic>(),
      translation: (fields[6] as Map)?.cast<String, dynamic>(),
      tafsir: (fields[7] as Map)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Surah obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.arabic)
      ..writeByte(2)
      ..write(obj.latin)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.totalAyah)
      ..writeByte(5)
      ..write(obj.ayah)
      ..writeByte(6)
      ..write(obj.translation)
      ..writeByte(7)
      ..write(obj.tafsir);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
