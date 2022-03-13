import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_onfido/data/gateways/onfido_channel_gateway.dart';
import 'package:flutter_onfido/domain/services/onfido_channel_services.dart';
import 'package:flutter_onfido/onfido_config.dart';

export './enums.dart';
export './onfido_config.dart';

const channel = MethodChannel('flutter_onfido');
const androidOnfidoGateway = AndroidOnfidoChannelGateway(channel: channel);
const iosOnfidoGateway = IOSOnfidoChannelGateway(channel: channel);
final onfidoChannelService = OnfidoChannelServiceImpl(
  androidOnfidoGateway: androidOnfidoGateway,
  iosOnfidoGateway: iosOnfidoGateway,
  isAndroid: Platform.isAndroid,
);

class FlutterOnfido {
  static Future<OnfidoResult> start({
    required OnfidoConfig config,
    OnfidoIOSAppearance iosAppearance = const OnfidoIOSAppearance(),
  }) async {
    return await onfidoChannelService.start(
      config,
      appearance: iosAppearance
    );
  }
}
