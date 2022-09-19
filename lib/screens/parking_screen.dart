import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sixth_app/models/cams.dart';
import 'package:sixth_app/screens/chat_screen.dart';
import 'package:sixth_app/widgets/parking_list.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/theme_provider.dart';

import 'package:http/http.dart' as http;
import '../widgets/pickers/globals.dart' as globals;

import '../widgets/change_theme_button_widget.dart';
import '../screens/chat_screen.dart';

var name;
var testText;

class ParkingScreen extends StatefulWidget {
  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen>
    with WidgetsBindingObserver {
  //
  final List<Cams> _cams = [
    Cams(
      number: 0,
      server: 'Камера 1',
    ),
    Cams(
      number: 1,
      server: 'Камера 2',
    ),
    Cams(
      number: 2,
      server: 'Камера 3',
    ),
  ];

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    Widget txListWidget,
    Widget webLink,
    Widget parkButton,
  ) {
    return [
      Container(
        child: txListWidget,
        height: 220,
      ),
      webLink,
      parkButton
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    Widget txListWidget,
    Widget webLink,
    Widget parkButton,
  ) {
    return [
      Container(
        child: txListWidget,
        height: 220,
      ),
      webLink,
      parkButton
    ];
  }
  //

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    //
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final parkButton = Container(
      child: FlatButton(
        textColor: Theme.of(context).accentColor,
        child: Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        },
      ),
    );
    var webLink = Container(
      height: 450,
      alignment: Alignment.center,
      child: WebView(initialUrl: globals.link),
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.7,
      child: ParkingList(_cams),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(
                  mediaQuery, txListWidget, webLink, parkButton),
            if (!isLandscape)
              ..._buildPortraitContent(
                mediaQuery,
                txListWidget,
                webLink,
                parkButton,
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            body: pageBody,
            appBar: AppBar(
              title: Text('Parking'),
              actions: [
                DropdownButton(
                  underline: Container(),
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.exit_to_app),
                            SizedBox(width: 8),
                            Text('Logout'),
                          ],
                        ),
                      ),
                      value: 'logout',
                    ),
                  ],
                  onChanged: (itemIdentifier) {
                    if (itemIdentifier == 'logout') {
                      FirebaseAuth.instance.signOut();
                    }
                  },
                ),
              ],
            ),
          );
  }
}
