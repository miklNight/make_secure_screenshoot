import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:make_secure_screenshoot/make_secure_screenshoot_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMakeSecureScreenshoot platform = MethodChannelMakeSecureScreenshoot();
  const MethodChannel channel = MethodChannel('make_secure_screenshoot');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
