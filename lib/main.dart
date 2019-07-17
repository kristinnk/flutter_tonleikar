import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import './screens/details.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: ConcertDataHome(),
    );
  }
}

class ConcertDataHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _concertDataHome();
  }
}

class _concertDataHome extends State<ConcertDataHome> {
  @override
  List data;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tónlist á Íslandi!'),
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            String dataUri = "http://www.mbl.is";
            return new Container(
                margin: EdgeInsets.all(5.0),
                child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          GestureDetector(
                              child: Card(
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Image.network(data[index]["imageSource"]),
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: InkWell(
                                              splashColor: Colors.deepOrange,
                                              child: Padding(
                                                  padding: EdgeInsets.only(left: 20.0),
                                                  child: Text(
                                                      data[index]["eventDateName"],
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w700))),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20.0, bottom: 15.0),
                                            child: Text(
                                              DateFormat('dd/MM yyyy, kk:mm').format(
                                                  DateTime.parse(
                                                      data[index]["dateOfShow"])),
                                              style: TextStyle(color: Colors.white30),
                                            )),
                                      ])
                              ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Details(data: data[index]))
                              );
                            },
                          ),

                        ])));
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    this._retrieveConcertAPIData();
  }

  Future<String> _retrieveConcertAPIData() async {
    var res = await http.get(Uri.encodeFull('https://apis.is/concerts'),
        headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });
    return "Success";
  }
}
