import 'dart:async';

import 'package:flutter/services.dart';

class FlutterOnfido {
  static const MethodChannel _channel =
      const MethodChannel('flutter_onfido');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
