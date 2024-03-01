
import 'make_secure_screenshoot_platform_interface.dart';

class MakeSecureScreenshoot {
  Future<String?> getPlatformVersion() {
    return MakeSecureScreenshootPlatform.instance.getPlatformVersion();
  }

  Future<String?> makeSecureScreenshoot() {
    return MakeSecureScreenshootPlatform.instance.makeSecureScreenshoot();
  }
  Future<String?> deSecureScreenshoot() {
    return MakeSecureScreenshootPlatform.instance.deSecureScreenshoot();
  }
}
