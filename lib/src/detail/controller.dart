import 'package:flutter/material.dart';
import 'package:passaport/src/app/components/listView.dart' show CustomListItem;

class DetailCtrl extends StatefulWidget {
  DetailCtrl({Key key, this.listItem}) : super(key: key);

  final CustomListItem listItem;

  @override
  DetailCtrlState createState() => new DetailCtrlState();
}

class DetailCtrlState extends State<DetailCtrl> {
  Widget _showDetail(CustomListItem listItem){
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                  color: Colors.white,
                  child: Image.asset(listItem.accDisplayImage, height: 200)
                ),
            )
          ],
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(15.0),
                decoration: new BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Username :', style: new TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    new Text(listItem.accUsername)
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.listItem.nickname),
        backgroundColor: Color.fromARGB(255, 26, 32, 38), //#263238
      ),
      body: _showDetail(widget.listItem),
      backgroundColor: Color.fromARGB(255, 29, 38, 44)
    );
  }
}
