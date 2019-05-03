import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passaport/models/application_identity.dart';
import 'package:passaport/screens/home_page.dart';
import 'package:passaport/src/passaport_database.dart';
import 'package:passaport/components/display_image.dart';

class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new NewPasswordScreenState();
  }
}

class NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Add New Identity"),
            backgroundColor: Color.fromARGB(255, 26, 32, 38)),
        body: _addNewIdentityWidget(),
        backgroundColor: Color.fromARGB(255, 29, 38, 44));
  }

  Widget _addNewIdentityWidget() {
    final TextEditingController usernameController = new TextEditingController();
    final TextEditingController passwordController = new TextEditingController();
    final TextEditingController nickNameController = new TextEditingController();

    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(
                child:
                    new Container(color: Colors.white),
              )
            ],
          ),
          LabelRow("Nickname"),
          _createEditRow(nickNameController),
          LabelRow("Username"),
          _createEditRow(usernameController),
          LabelRow("Password"),
          _createEditRow(passwordController),
          new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: new RaisedButton(
                  onPressed: () {
                    var app = new ApplicationIdentity(nickname :nickNameController.text.trim(), accUsername: usernameController.text.trim(), 
                    accDisplayImage: new DisplayImage().getDisplayImageOfAccount(usernameController.text, nickNameController.text), password:passwordController.text.trim());
                    DBProvider.db.newApplicationIdentity(app).then((response){
                       if(response != null && response > 0){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                       }
                    });
                  },
                  child: const Text("Save"),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(10)),
              margin: const EdgeInsets.only(top: 10),
            )
          ],
        )
        ],
      ),
    );
  }

  Widget _createEditRow(TextEditingController controller){
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
                  new TextFormField(
                      textInputAction: TextInputAction.next, autofocus: true, controller: controller),
                ]),
          ),
        )
      ],
    );
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

class EditRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EditRowState();
  }
}

class EditRowState extends State<EditRow> {
  final myController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
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
                  new TextFormField(
                      textInputAction: TextInputAction.next, autofocus: true, controller: myController),
                ]),
          ),
        )
      ],
    );
  }
}
