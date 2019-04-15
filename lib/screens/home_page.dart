import 'package:flutter/material.dart';
import 'package:passaport/components/password_listview.dart' show PasswordListView;
import 'package:passaport/models/application_identity.dart';
import 'package:passaport/screens/new_password.dart';
import 'package:passaport/screens/password_detail.dart';
import 'package:passaport/src/passaport_database.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List<ApplicationIdentity> _itemList = [];

  void _callback(int listItemId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailPage(listItem: _itemList[listItemId])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Passaport"),backgroundColor: Color.fromARGB(255, 26, 32, 38)),
      body: FutureBuilder<List<ApplicationIdentity>>(
        future: DBProvider.db.getAllApplicationIdentities(),
        builder: (BuildContext context, AsyncSnapshot<List<ApplicationIdentity>> snapshot) {
          if (snapshot.hasData) {
            _itemList = snapshot.data;
            return new PasswordListView(listItems: snapshot.data, callback: this._callback)
        .create();
        }}
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewPasswordScreen()));
          setState(() {});
        },
      ),
      backgroundColor: Color.fromARGB(255, 29, 38, 44)
    );
  }
}
