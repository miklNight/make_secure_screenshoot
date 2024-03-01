import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'make_secure_screenshoot_method_channel.dart';

abstract class MakeSecureScreenshootPlatform extends PlatformInterface {
  /// Constructs a MakeSecureScreenshootPlatform.
  MakeSecureScreenshootPlatform() : super(token: _token);

  static final Object _token = Object();

  static MakeSecureScreenshootPlatform _instance = MethodChannelMakeSecureScreenshoot();

  /// The default instance of [MakeSecureScreenshootPlatform] to use.
  ///
  /// Defaults to [MethodChannelMakeSecureScreenshoot].
  static MakeSecureScreenshootPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MakeSecureScreenshootPlatform] when
  /// they register themselves.
  static set instance(MakeSecureScreenshootPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> makeSecureScreenshoot() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> deSecureScreenshoot() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
