import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:make_secure_screenshoot/make_secure_screenshoot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool? _secureStatus;
  final _makeSecureScreenshootPlugin = MakeSecureScreenshoot();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _makeSecureScreenshootPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getSecureStatus() async {
    bool? status;
    try {
      status = await _makeSecureScreenshootPlugin.getSecureStatus();
      setState(() => _secureStatus = status);
    } on PlatformException {
      status = null;
    }
  }

  Future<void> makeSecure() async {
    var result = await _makeSecureScreenshootPlugin.makeSecure();
    setState(() => _secureStatus = result);
    //getSecureStatus();
  }

  Future<void> removeSecure() async {
    await _makeSecureScreenshootPlugin.removeSecure();
    getSecureStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('Make Secure Screenshoot'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Current status: $_secureStatus\n', style: const TextStyle(fontSize: 16)),
                  ElevatedButton(onPressed: () => getSecureStatus(), child: const Text("Refresh")),
                  const SizedBox(height: 16.0),
                  Builder(builder: (context) {
                    if (_secureStatus ?? false) {
                      return const Text(
                        "If you take a screenshot or start recording the screen, you will get a black screen",
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Text(
                        "Secure screen is not active, you can take screenshots",
                        textAlign: TextAlign.center,
                      );
                    }
                  })
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () => makeSecure(), child: const Text("Make Secure")),
                  ElevatedButton(onPressed: () => removeSecure(), child: const Text("Remove Secure")),
                ],
              ),
              Text('Running on: $_platformVersion\n'),
            ],
          ),
        ),
      ),
    );
  }
}
