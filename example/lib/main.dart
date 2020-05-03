import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_onfido/flutter_onfido.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      var result = await FlutterOnfido.start(
        OnfidoConfig(
          sdkToken: "",
          flowSteps: OnfidoFlowSteps(
            welcome: false,
            captureDocument:
                CaptureDocumentStep(countryCode: OnfidoCountryCode.USA, docType: OnfidoDocumentType.GENERIC),
          ),
        ),
        OnfidoAppearance(),
      );
      print(result);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              RaisedButton(
                onPressed: initPlatformState,
              )
            ],
          ),
        ),
      ),
    );
  }
}
