import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_onfido/onfido_config.dart';

export './enums.dart';
export './onfido_config.dart';

class FlutterOnfido {
  static const MethodChannel _channel = const MethodChannel('flutter_onfido');
  static const JsonDecoder _jsonDecoder = const JsonDecoder();
  static const JsonEncoder _jsonEncoder = const JsonEncoder();

  static Future<OnfidoResult> start({
    required OnfidoConfig config,
    OnfidoIOSAppearance iosAppearance = const OnfidoIOSAppearance(),
  }) async {
    final error = _validateConfig(config);
    if (error != null) {
      throw OnfidoConfigValidationException(error);
    }
    final confingJson = config.toJson();
    final result = await _channel.invokeMethod('start', {
      "config": confingJson,
      "appearance": iosAppearance.toJson(),
    });
    return OnfidoResult.fromJson(
        _jsonDecoder.convert(_jsonEncoder.convert(result)));
  }

  static String? _validateConfig(OnfidoConfig config) {
    if (config == null) {
      return "Config is missing";
    }
    if (config.sdkToken == null || config.sdkToken!.isEmpty) {
      return "Sdk token is missing";
    }
    if (!RegExp(r'^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.?[A-Za-z0-9-_.+/=]*$')
        .hasMatch(config.sdkToken!)) {
      return "Sdk token is not valid JWT";
    }
    if (config.flowSteps == null) {
      return "Flow steps configuration is missing";
    }
    if (config.flowSteps!.captureDocument == null &&
        config.flowSteps!.captureFace == null) {
      return "Flow steps doesn't include either captureDocument options or captureFace options";
    }
    return null;
  }
}

class OnfidoConfigValidationException implements Exception {
  final String message;
  OnfidoConfigValidationException(this.message);
}
