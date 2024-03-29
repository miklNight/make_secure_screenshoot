import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'make_secure_screenshoot_platform_interface.dart';

/// An implementation of [MakeSecureScreenshootPlatform] that uses method channels.
class MethodChannelMakeSecureScreenshoot extends MakeSecureScreenshootPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('make_secure_screenshoot');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> makeSecure() async {
    return await methodChannel.invokeMethod<bool>('makeSecure');
  }

  @override
  Future<bool?> removeSecure() async {
    return await methodChannel.invokeMethod<bool>('removeSecure');
  }

  @override
  Future<bool?> getSecureStatus() async {
    final status = await methodChannel.invokeMethod<bool>('getSecureStatus');
    return status; //?? false;
  }
}
