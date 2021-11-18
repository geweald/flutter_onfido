import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_onfido/data/gateways/onfido_channel_gateway.dart';
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
    final onfidoChannel = AndroidOnfidoChannelGateway(channel: _channel);
    final result = onfidoChannel.start(config);
    return OnfidoResult.fromJson(
      _jsonDecoder.convert(
        _jsonEncoder.convert(result),
      ),
    );
  }
}
