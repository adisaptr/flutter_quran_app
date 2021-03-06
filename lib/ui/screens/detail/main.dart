import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:quran_app/model/Ayah.dart';
import 'package:quran_app/model/Surah.dart';

class Detail extends StatefulWidget {
  final Surah surah;

  Detail({Key key, this.surah}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool _loading = false;
  List<Ayah> _listAyah = [];
  void initState() {
    super.initState();

    this.mapAyah();
  }

  void mapAyah() {
    setState(() {
      _loading = true;
      _listAyah.clear();
    });

    List<Ayah> temp = [];
    for (var i = 0; i < widget.surah.totalAyah; i++) {
      var ayah = new Ayah();
      ayah.index = i + 1;
      ayah.arabic = widget.surah.ayah['${i + 1}'];
      ayah.indonesia = widget.surah.translation['${i + 1}'];
      ayah.tafsir = widget.surah.tafsir['${i + 1}'];
      temp.add(ayah);
    }

    setState(() {
      _loading = false;
      _listAyah = temp;
    });
  }

  Future<void> showTafsir(context, index) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${widget.surah.latin} : ${index + 1}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('${_listAyah[index].tafsir}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Tutup'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: kIsWeb
              ? CrossAxisAlignment.center
              : (Platform.isAndroid
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center),
          children: [
            Text('${widget.surah.latin} (${widget.surah.arabic})'),
            Text(
              '${widget.surah.name} | ${widget.surah.totalAyah} Ayat',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Color(0xff2ED1A2),
      ),
      body: _loading
          ? Center(
              child: Text('Sedang memuat konten...'),
            )
          : ListView.builder(
              itemCount: widget.surah.totalAyah,
              itemBuilder: (BuildContext ctx, int index) {
                return GestureDetector(
                  onTap: () {
                    this.showTafsir(context, index);
                  },
                  child: Card(
                    elevation: 3.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 4.0),
                          child: Text(
                            '${index + 1}.',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 12.0, right: 6.0, bottom: 6.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      _listAyah[index].arabic,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 24, fontFamily: "LPMQ"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 12, bottom: 6.0),
                                  child: Text(
                                    _listAyah[index].indonesia,
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
