import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_onfido/flutter_onfido.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> init() async {
    try {
      var result = await FlutterOnfido.start(
        config: OnfidoConfig(
          sdkToken:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c", // PROVIDE TOKEN YOU'VE GOT FROM YOUR BACKEND
          flowSteps: OnfidoFlowSteps(
              welcome: false,
              captureDocument: OnfidoCaptureDocumentStep(
                countryCode: OnfidoCountryCode.USA,
                docType: OnfidoDocumentType.GENERIC,
              ),
              captureFace: OnfidoCaptureFaceStep(OnfidoCaptureType.PHOTO)),
        ),
        iosAppearance: OnfidoIOSAppearance(
          onfidoPrimaryColor: "#0043DF",
        ),
      );
      print(result);
      // ASK YOUR BACKEND IF USER HAS PASSED VERIFICATION
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
              RaisedButton(
                onPressed: init,
              )
            ],
          ),
        ),
      ),
    );
  }
}
