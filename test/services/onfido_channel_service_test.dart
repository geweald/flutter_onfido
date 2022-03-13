import 'package:flutter_onfido/data/gateways/onfido_channel_gateway.dart';
import 'package:flutter_onfido/domain/services/onfido_channel_services.dart';
import 'package:flutter_onfido/onfido_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAndroidOnfidoChannelGateway extends Mock
    implements AndroidOnfidoChannelGateway {}

class MockIOSOnfidoChannelGateway extends Mock
    implements IOSOnfidoChannelGateway {}

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

const onfidoResultJson = <String, dynamic>{
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
  final androidOnfidoChannelGateway = MockAndroidOnfidoChannelGateway();
  final iosOnfidoChannelGateway = MockIOSOnfidoChannelGateway();

  OnfidoChannelService? onfidoChannelService;

  setUpAll(() {
    registerFallbackValue(FakeOnfidoConfig());
  });

  group('Android onfido channel service', () {
    setUp(() {
      onfidoChannelService = OnfidoChannelServiceImpl(
        androidOnfidoGateway: androidOnfidoChannelGateway,
        iosOnfidoGateway: iosOnfidoChannelGateway,
        isAndroid: true,
      );
    });
    test('should return onfido result', () async {
      when(
        () => androidOnfidoChannelGateway.start(any()),
      ).thenAnswer(
        (_) async => onfidoResultJson,
      );

      final result = await onfidoChannelService!.start(FakeOnfidoConfig());

      expect(result, isA<OnfidoResult>());
    });
  });

  group('IOS onfido channel service', () {
    setUp(() {
      onfidoChannelService = OnfidoChannelServiceImpl(
        androidOnfidoGateway: androidOnfidoChannelGateway,
        iosOnfidoGateway: iosOnfidoChannelGateway,
        isAndroid: false,
      );
    });
    test('should return onfido result', () async {
      when(
        () => iosOnfidoChannelGateway.start(any()),
      ).thenAnswer(
        (_) async => onfidoResultJson,
      );

      final result = await onfidoChannelService!.start(FakeOnfidoConfig());

      expect(result, isA<OnfidoResult>());
    });
  });
}
