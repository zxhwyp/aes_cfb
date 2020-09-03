import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Aescfb {
  static const MethodChannel _channel = const MethodChannel('aescfb');

  static Future<String> encryptWithAescfb(
      {@required String value, @required String key}) async {
    final String result =
        await _channel.invokeMethod('encrypt', {'key': key, 'value': value});
    return result;
  }

  static Future<String> dencryptWithAescfb(
      {@required String value, @required String key}) async {
    final String result =
        await _channel.invokeMethod('dencrypt', {'key': key, 'value': value});
    return result;
  }
}
