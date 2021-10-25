import 'package:flutter/material.dart';
import 'package:quran_app/model/Surah.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quran_app/ui/screens/detail/main.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();
  String query = '';
  void initState() {
    super.initState();
  }

  void loadSurah() async {
    var surah = Hive.box('surah');
    for (var i = 1; i <= 114; i++) {
      String raw = await rootBundle.loadString('assets/surah/$i.json');
      var obj = json.decode(raw);
      var item = Surah.fromJson(obj['$i']);
      surah.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/splash.png',
          scale: 15,
        ),
        // title: Text('AL-QURAN',
        //     style: TextStyle(
        //         fontFamily: "LPMQ", color: Colors.white, fontSize: 20)),
        elevation: 0,
        backgroundColor: Color(0xff2ED1A2),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: new Padding(
                padding: const EdgeInsets.all(3.0),
                child: new Card(
                  child: new ListTile(
                    title: new TextField(
                      autofocus: false,
                      autocorrect: false,
                      controller: _searchController,
                      decoration: new InputDecoration(
                          hintText: 'Cari', border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          this.query = value;
                        });
                      },
                    ),
                    trailing: new Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: Hive.openBox('surah'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error),
                      );
                    } else {
                      var surah = Hive.box('surah');
                      if (surah.length == 0) {
                        this.loadSurah();
                      }
                      return ValueListenableBuilder(
                        valueListenable: surah.listenable(),
                        builder: (BuildContext context, Box<dynamic> value,
                            Widget child) {
                          var results = query == ''
                              ? surah.values.toList()
                              : surah.values
                                  .where((c) =>
                                      c.latin.toLowerCase().contains(query))
                                  .toList();
                          return results.length == 0
                              ? Center(
                                  child: Text('Tidak Ditemukan'),
                                )
                              : Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ListView.builder(
                                    itemCount: results.length,
                                    itemBuilder: (context, index) {
                                      Surah surah1 = results[index];
                                      return ListTile(
                                        title: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${surah1.number}. ${surah1.latin}'),
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(surah1.arabic,
                                                  style: TextStyle(
                                                      fontFamily: "LPMQ")),
                                            )
                                          ],
                                        ),
                                        subtitle: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(surah1.name),
                                            Text('${surah1.totalAyah} Ayat')
                                          ],
                                        ),
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          new TextEditingController().clear();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext c) =>
                                                    Detail(surah: surah1),
                                              ));
                                        },
                                      );
                                    },
                                  ),
                                );
                        },
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
