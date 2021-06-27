// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin/flutter_plugin.dart';

void main() {
  runApp(MyApp());
}
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'URL Launcher'),
    );
  }
}
*/

class MyApp extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  //final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _dialogResult = 'Unknown';
  //Future<void> _launched;
  String _phone = '09024922369';

  // Get state.
  String _androidphone = 'Dial';
  String _hangstate = "HangUp";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  //void setState() async {
  //  _androidphone = phonestate;
  //  _hangstate = hangupstate;
  //}

  Future<void> initPlatformState() async {
    String dialogResult;
    try {
      dialogResult = await PlatformOriginDialog.showDialog("確認", "保存しますか？");
    } on PlatformException {
      dialogResult = 'Failed to show Dialog.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _dialogResult = dialogResult;
    });
  }

  Future<void> _getphonestate() async {
    String phonestate;

    try {
      final String result = await FlutterPlugin.phonetate;
      phonestate = 'phone state at $result';
    } on PlatformException catch (e) {
      phonestate = "Failed to get androidphone: '${e.message}'.";
    }

    setState(() {
      _androidphone = phonestate;
      //_hangstate = hangupstate;
    });
  }

  Future<void> _hangupstate() async {
    String hangupstate;
    try {
      final String result = await FlutterPlugin.hangupstate;
      hangupstate = 'phone state at $result';
    } on PlatformException catch (e) {
      hangupstate = "Failed to get androidphone: '${e.message}'.";
    }

    setState(() {
      _hangstate = hangupstate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                  onChanged: (String text) => _phone = text,
                  decoration: const InputDecoration(
                      labelText: "incoming phonenumber",
                      hintText: "{_androidphone}")),
            ),
            RaisedButton(
              onPressed: () => setState(() {
                _hangupstate();
              }),
              child: Text(_hangstate),
            ),
            RaisedButton(
              onPressed: () => setState(() {
                _getphonestate();
              }),
              child: Text(_androidphone),
            ),
          ],
        ),
      ),
    );
  }
}
//flutter create --org com.sumitomo --template=plugin -i swift -a java ticketcall
