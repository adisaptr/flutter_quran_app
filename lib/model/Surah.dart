import 'package:hive/hive.dart';
part 'Surah.g.dart';

@HiveType(typeId: 0)
class Surah {
  @HiveField(0)
  int number;
  @HiveField(1)
  String arabic;
  @HiveField(2)
  String latin;
  @HiveField(3)
  String name;
  @HiveField(4)
  int totalAyah;
  @HiveField(5)
  Map<String, dynamic> ayah;
  @HiveField(6)
  Map<String, dynamic> translation;
  @HiveField(7)
  Map<String, dynamic> tafsir;

  Surah(
      {this.number,
      this.arabic,
      this.name,
      this.latin,
      this.totalAyah,
      this.ayah,
      this.translation,
      this.tafsir});

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
        number: int.parse(json['number']),
        arabic: json['name'],
        name: json['translations']['id']['name'],
        latin: json['name_latin'],
        totalAyah: int.parse(json['number_of_ayah']),
        ayah: json['text'],
        translation: json['translations']['id']['text'],
        tafsir: json['tafsir']['id']['kemenag']['text']);
  }
}
