import 'package:flutter_test/flutter_test.dart';
import 'package:make_secure_screenshoot/make_secure_screenshoot.dart';
import 'package:make_secure_screenshoot/make_secure_screenshoot_platform_interface.dart';
import 'package:make_secure_screenshoot/make_secure_screenshoot_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMakeSecureScreenshootPlatform
    with MockPlatformInterfaceMixin
    implements MakeSecureScreenshootPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MakeSecureScreenshootPlatform initialPlatform = MakeSecureScreenshootPlatform.instance;

  test('$MethodChannelMakeSecureScreenshoot is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMakeSecureScreenshoot>());
  });

  test('getPlatformVersion', () async {
    MakeSecureScreenshoot makeSecureScreenshootPlugin = MakeSecureScreenshoot();
    MockMakeSecureScreenshootPlatform fakePlatform = MockMakeSecureScreenshootPlatform();
    MakeSecureScreenshootPlatform.instance = fakePlatform;

    expect(await makeSecureScreenshootPlugin.getPlatformVersion(), '42');
  });
}
