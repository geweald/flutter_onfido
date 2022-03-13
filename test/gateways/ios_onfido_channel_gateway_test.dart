import 'package:flutter/services.dart';
import 'package:flutter_onfido/data/gateways/onfido_channel_gateway.dart';
import 'package:flutter_onfido/flutter_onfido.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeOnfidoConfig extends Fake implements OnfidoConfig {
  @override
  Map<String, dynamic> toJson() {
    return {
      "sdkToken": "SDK_TOKEN",
      "flowSteps": {
        "welcome": true,
        "captureDocument": {
          "docType": "GENERIC",
          "countryCode": "USA",
        },
        "captureFace": {
          "type": "PHOTO",
        },
      },
    };
  }
}

class FakeOnfidoIOSApparence extends Fake implements OnfidoIOSAppearance {
  @override
  Map<String, dynamic> toJson() {
    return {
      "onfidoPrimaryColor": "#0043DF",
      "onfidoIosSupportDarkMode": false,
    };
  }
}

const onfidoResultJson = {
  'document': {
    'front': {
      'id': 'UUID 01',
    },
    'back': {
      'id': 'UUID 02',
    }
  },
  'face': {
    'id': 'UUID FACE',
    'variant': 'PHOTO',
  },
};

void main() {
  const methodChannel = MethodChannel('flutter_onfido');

  late IOSOnfidoChannelGateway iosOnfidoChannelGateway;

  TestWidgetsFlutterBinding.ensureInitialized();

  group('IOS onfido channel gateway', () {
    setUp(
      () {
        iosOnfidoChannelGateway = const IOSOnfidoChannelGateway(
          channel: methodChannel,
        );
        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          methodChannel,
          (channel) async {
            if (channel.method == 'start') {
              return onfidoResultJson;
            }
          },
        );
      },
    );

    test('start with apparence', () async {
      final result = await iosOnfidoChannelGateway.start(
        FakeOnfidoConfig(),
        appearance: FakeOnfidoIOSApparence(),
      );

      expect(result, onfidoResultJson);
    });

    test('start without apparence', () async {
      final result = await iosOnfidoChannelGateway.start(
        FakeOnfidoConfig(),
      );

      expect(result, onfidoResultJson);
    });
  });
}
