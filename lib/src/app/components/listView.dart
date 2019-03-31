import 'package:flutter/material.dart';

class CustomListItem {
  final int id;
  final String nickname;
  final String accUsername;
  final String accDisplayImage;

  CustomListItem(
      {this.id, this.nickname, this.accUsername, this.accDisplayImage});
}

typedef void OnTapCallback(int index);

class CustomListView {
  CustomListView({this.listItems, this.callback});

  final List<CustomListItem> listItems;
  final OnTapCallback callback;

  final TextStyle _nicknameFont = new TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white);
  final TextStyle _accountUsernameFont =
      new TextStyle(fontSize: 16.0, color: Colors.white);

  Widget _createRow(CustomListItem listItem) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 10.0),
          width: 50,
          height: 50,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              //image: new NetworkImage(listItem.accDisplayImage)
              image: new AssetImage(listItem.accDisplayImage)
            )
          ),
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            new Text(
            listItem.nickname,
            style: _nicknameFont,
          ),
          new Container(
            margin: const EdgeInsets.only(top:10.0),
            child: new Text(
              listItem.accUsername,
              style: _accountUsernameFont,
            )
          )
        ]
        )
      ],
    );
  }

  Widget _createListTile(CustomListItem listItem, OnTapCallback onTapCallback, int index) {
    return new ListTile(
      title: _createRow(listItem),
      trailing: new Icon(Icons.keyboard_arrow_right, color: Colors.white),
      onTap: () {
        onTapCallback(index);
      },
    );
  }

  Widget _createList(List<CustomListItem> listItems, OnTapCallback callback) {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return new Divider(color: Colors.white,);
        }

        final int index = i ~/ 2;
        if (index < listItems.length) {
          return _createListTile(listItems[index], callback, index);
        }
      },
    );
  }

  Widget create() {
    return _createList(this.listItems, this.callback);
  }
}
