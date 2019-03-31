import 'package:flutter/material.dart';
import 'package:passaport/src/app/components/listView.dart'
    show CustomListItem, CustomListView;
import 'package:passaport/src/detail/controller.dart' show DetailCtrl;

class HomeCtrl extends StatefulWidget {
  @override
  HomeCtrlState createState() => new HomeCtrlState();
}

class HomeCtrlState extends State<HomeCtrl> {
  List<CustomListItem> _itemList = [];

  void _callback(int listItemId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailCtrl(listItem: _itemList[listItemId])),
    );
  }

  Widget _createDummyListView() {
    _itemList.clear();
    _itemList.add(new CustomListItem(
        id: 1,
        nickname: 'First Item',
        accUsername: 'first@item.org',
        accDisplayImage: 'assets/images/microsoft-logo.jpg'));

    _itemList.add(new CustomListItem(
        id: 2,
        nickname: 'Second Item',
        accUsername: 'second@item.org',
        accDisplayImage: 'assets/images/microsoft-logo.jpg'));

    return new CustomListView(listItems: _itemList, callback: this._callback)
        .create();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Accounts'),
          backgroundColor: Color.fromARGB(255, 26, 32, 38), //#263238
        ),
        body: _createDummyListView(),
        backgroundColor: Color.fromARGB(255, 29, 38, 44) //#293844
        );
  }
}
