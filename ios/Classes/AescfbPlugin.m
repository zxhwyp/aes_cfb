#import "AescfbPlugin.h"
#if __has_include(<aescfb/aescfb-Swift.h>)
#import <aescfb/aescfb-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "aescfb-Swift.h"
#endif

@implementation AescfbPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAescfbPlugin registerWithRegistrar:registrar];
}
@end
