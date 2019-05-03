import 'package:flutter/material.dart';
import 'package:passaport/models/application_identity.dart';

typedef void OnTapCallback(int index);

class PasswordListView {
  final List<ApplicationIdentity> listItems;
  final OnTapCallback callback;

  PasswordListView({this.listItems, this.callback});

  final TextStyle _nicknameFont = new TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white);
  final TextStyle _accountUsernameFont =
      new TextStyle(fontSize: 16.0, color: Colors.white);

  Widget create() {
    return _createList(this.listItems, this.callback);
  }

  Widget _createList(
      List<ApplicationIdentity> listItems, OnTapCallback callback) {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (_, int index) {
        if (index.isOdd) {
          return new Divider(color: Colors.white);
        }

        final int itemIndex = index ~/ 2;
        if (itemIndex < listItems.length) {
          return _createListTile(listItems[itemIndex], callback, itemIndex);
        }
      },
    );
  }

  Widget _createListTile(
      ApplicationIdentity listItem, OnTapCallback onTapCallback, int index) {
    return new ListTile(
      title: _createRow(listItem),
      trailing: new Icon(Icons.keyboard_arrow_right, color: Colors.white),
      onTap: () {
        onTapCallback(index);
      },
    );
  }

  Widget _createRow(ApplicationIdentity listItem) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 15.0),
          width: 50,
          height: 50,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: new AssetImage(listItem.accDisplayImage))),
        ),
        new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                listItem.nickname,
                style: _nicknameFont,
              ),
              new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new Text(
                    listItem.accUsername,
                    style: _accountUsernameFont,
                  ))
            ])
      ],
    );
  }
}
