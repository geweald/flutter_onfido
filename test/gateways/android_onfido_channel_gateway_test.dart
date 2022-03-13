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

  late AndroidOnfidoChannelGateway androidOnfidoChannelGateway;

  TestWidgetsFlutterBinding.ensureInitialized();

  group('Android onfido channel gateway', () {
    setUp(
      () {
        androidOnfidoChannelGateway = const AndroidOnfidoChannelGateway(
          channel: methodChannel,
        );
        TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
            .setMockMethodCallHandler(
          methodChannel,
          (channel) async {
            if (channel.method == 'start') {
              return onfidoResultJson;
            }

            return null;
          },
        );
      },
    );

    test('start', () async {
      final result = await androidOnfidoChannelGateway.start(
        FakeOnfidoConfig(),
      );

      expect(result, onfidoResultJson);
    });
  });
}
