import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  var data;

  Details({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Details(data);
  }
}

class _Details extends State<Details> {
  var recData;

  _Details(this.recData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(recData["name"])),
        body: ListView(
          children: <Widget>[
            Card(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.network(recData["imageSource"]),
                Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(recData["eventDateName"],
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 10.0),
                    child: Text(
                      DateFormat('dd/MM yyyy, kk:mm')
                          .format(DateTime.parse(recData["dateOfShow"])),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 10.0),
                    child: Text('Aðstandendur : ' + recData["userGroupName"])),
                Padding(
                    padding:
                        EdgeInsets.only(left: 30.0, top: 10.0, bottom: 20.0),
                    child: Text('Staður : ' + recData["eventHallName"])),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, bottom: 20.0, right: 30.0),
                  child: RaisedButton(
                      onPressed: () {
                        String imagePath = recData["imageSource"];
                        String concertId = imagePath.substring(imagePath.length - 9).substring(0,5);
                        String newUrl = "https://midi.frettabladid.is/atburdir/1/" + concertId;
                        _openUrl(newUrl);
                      },
                        child: Text("Skoða á miði.is")

                      ),
                )
              ],
            ))
          ],
        ));
  }

  _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Gat ekki opnað slóð.';
    }
  }
}
