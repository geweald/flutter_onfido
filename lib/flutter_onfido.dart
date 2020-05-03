import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_onfido/onfido_config.dart';

class FlutterOnfido {
  static const MethodChannel _channel = const MethodChannel('flutter_onfido');

  static Future<OnfidoResult> start(OnfidoConfig config, OnfidoAppearance appearance) async {
    final error = _validateConfig(config);
    if (error != null) {
      throw Exception(error);
    }

    final result = await _channel.invokeMethod('start', {
      "config": config.toJson(),
      "appearance": appearance.toJson(),
    });
    return OnfidoResult.fromJson(result);
  }

  static String _validateConfig(OnfidoConfig config) {
    if (config == null) {
      return "Config is missing";
    }
    if (config.sdkToken == null || config.sdkToken.isEmpty) {
      return "Sdk token is missing";
    }
    if (!RegExp(r'^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.?[A-Za-z0-9-_.+/=]*$').hasMatch(config.sdkToken)) {
      return "Sdk token is not valid JWT";
    }
    if (config.flowSteps == null) {
      return "Flow steps configuration is missing";
    }
    if (config.flowSteps.captureDocument == null && config.flowSteps.captureFace == null) {
      return "Flow steps doesn't include either captureDocument options or captureFace options";
    }
    return null;
  }
}
