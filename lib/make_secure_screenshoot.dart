import 'make_secure_screenshoot_platform_interface.dart';

class MakeSecureScreenshoot {
  Future<String?> getPlatformVersion() {
    return MakeSecureScreenshootPlatform.instance.getPlatformVersion();
  }

  Future<bool?> makeSecure() {
    return MakeSecureScreenshootPlatform.instance.makeSecure();
  }

  Future<bool?> removeSecure() {
    return MakeSecureScreenshootPlatform.instance.removeSecure();
  }

  Future<bool?> getSecureStatus() {
    return MakeSecureScreenshootPlatform.instance.removeSecure();
  }
}
