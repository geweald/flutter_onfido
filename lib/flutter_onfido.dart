import 'dart:async';

import 'package:flutter/services.dart';

class FlutterOnfido {
  static const MethodChannel _channel = const MethodChannel('flutter_onfido');

  static Future<dynamic> get platformVersion async {
    final version = await _channel.invokeMethod('start', {
      "config": {
        "sdkToken": "",
        "flowSteps": {
          "welcome": true,
          "captureDocument": {"docType": "GENERIC", "countryCode": "USA"},
          "captureFace": {"type": "PHOTO"}
        }
      },
      "appearance": {
        "onfidoPrimaryColor": "#FF0000",
        "onfidoPrimaryButtonTextColor": "#008000",
        "onfidoPrimaryButtonColorPressed": "#FFA500",
        "onfidoAndroidStatusBarColor": "#A52A2A",
        "onfidoAndroidToolBarColor": "#800080",
        "onfidoIosSupportDarkMode": true
      }
    });
    return version;
  }
}
