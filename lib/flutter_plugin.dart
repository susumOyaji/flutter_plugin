import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPlugin {
  static const MethodChannel _channel = const MethodChannel('flutter_plugin');
  static const MethodChannel _platform =
      const MethodChannel('samples.flutter.io/androidphone');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get phonetate async {
    String _phone;
    final String phonestate =
        await _platform.invokeMethod('androidphone', _phone);
    return phonestate;
  }

  static Future<String> get hangupstate async {
    //String hangupstate;
    final String phonestate = await _platform.invokeMethod('hangup', true);
    return phonestate;
  }
}

class PlatformOriginDialog {
  static const MethodChannel _channel =
      const MethodChannel('platform_origin_dialog');

  static Future<String> showDialog(String title, String message) async {
    final String result =
        await _channel.invokeMethod('show_dialog', <String, dynamic>{
      'title': title,
      'message': message,
    });
    return result;
  }
}
