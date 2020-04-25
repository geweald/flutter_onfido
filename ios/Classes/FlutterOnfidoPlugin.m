#import "FlutterOnfidoPlugin.h"
#if __has_include(<flutter_onfido/flutter_onfido-Swift.h>)
#import <flutter_onfido/flutter_onfido-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_onfido-Swift.h"
#endif

@implementation FlutterOnfidoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterOnfidoPlugin registerWithRegistrar:registrar];
}
@end
