import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_onfido/flutter_onfido.dart';

abstract class OnfidoChannelGateway {
  Future<Object> start(OnfidoConfig config);
}

class AndroidOnfidoChannelGateway implements OnfidoChannelGateway {
  const AndroidOnfidoChannelGateway({required this.channel});

  final MethodChannel channel;

  @override
  Future<Map<String, dynamic>> start(OnfidoConfig config) async {
    final result = await channel.invokeMethod('start', {
      'config': config.toJson(),
    });
    
    return jsonDecode(jsonEncode(result));
  }
}

class IOSOnfidoChannelGateway implements OnfidoChannelGateway {
  const IOSOnfidoChannelGateway({required this.channel});

  final MethodChannel channel;

  @override
  Future<Map<String, dynamic>> start(
    OnfidoConfig config, {
    OnfidoIOSAppearance appearance = const OnfidoIOSAppearance(),
  }) async {
    final result = await channel.invokeMethod('start', {
      "config": config.toJson(),
      "appearance": appearance.toJson(),
    });

    return jsonDecode(jsonEncode(result));
  }
}
