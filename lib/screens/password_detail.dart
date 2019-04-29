import 'package:flutter/material.dart';
import 'package:passaport/models/application_identity.dart';
import 'package:passaport/screens/home_page.dart';
import 'package:passaport/src/passaport_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPage extends StatefulWidget {
  final ApplicationIdentity listItem;

  DetailPage({Key key, this.listItem}) : super(key: key);

  @override
  DetailPageState createState() => new DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Widget _showDetail(ApplicationIdentity listItem) {
    _usernameController.text = listItem.accUsername;
    _passwordController.text = listItem.password;

    return new SingleChildScrollView(
        child: new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                  color: Colors.white,
                  child: Image.asset("assets/images/microsoft-logo.jpg",
                      height: 200)),
            )
          ],
        ),
        LabelRow("Username"),
        _createEditRow(_usernameController),
        LabelRow("Password"),
        _createEditRow(_passwordController),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: new RaisedButton(
                  onPressed: () {
                    _updatePasswordItem(listItem.id, _usernameController.text,
                        _passwordController.text, context);
                  },
                  child: const Text("Update"),
                  color: Colors.green,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(10)),
              margin: const EdgeInsets.only(top: 10),
            ),
            Container(
              child: new RaisedButton(
                  onPressed: () {
                    _deletePasswordItem(listItem.id, context);
                  },
                  child: const Text("Delete"),
                  color: Colors.red,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(10)),
              margin: const EdgeInsets.only(left: 10, top: 10),
            )
          ],
        )
      ],
    ));
  }

  Widget _createEditRow(TextEditingController controller) {
    var cursorPos = controller.selection;
    controller.text = controller.text ?? '';
    cursorPos = new TextSelection.fromPosition(
        new TextPosition(offset: controller.text.length));
    controller.selection = cursorPos;

    return Row(
      children: <Widget>[
        new Expanded(
          child: new Container(
            margin: const EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(15),
            decoration: new BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new TextField(controller: controller),
                ]),
          ),
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
        backgroundColor: Color.fromARGB(255, 29, 38, 44));
  }
}

class LabelRow extends StatelessWidget {
  final String _propertyName;

  LabelRow(this._propertyName);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.all(15.0),
            decoration: new BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(this._propertyName,
                    style: new TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        )
      ],
    );
  }
}

VoidCallback _updatePasswordItem(
    int itemId, String username, String password, BuildContext context) {
  DBProvider.db.getApplicationIdentity(itemId).then((response) {
    if (response != null) {
      response.accUsername = username;
      response.password = password;
      DBProvider.db.updateApplicationIdentity(response).then((result) {
        if (result > 0) {
          Fluttertoast.showToast(msg: "Identity was updated successfully.");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Fluttertoast.showToast(msg: "Error occured!");
        }
      });
    }
  });
  return null;
}

VoidCallback _deletePasswordItem(int itemId, BuildContext context) {
  DBProvider.db.deleteApplicationIdentity(itemId).then((result) {
    if (result > 0) {
      Fluttertoast.showToast(msg: "Identity was deleted successfully.");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(msg: "Error occured!");
    }
  });
  return null;
}
