library;

import 'package:flutter/services.dart';

class GithubApkUpdater {
  static const MethodChannel _channel = MethodChannel('flutter_app_updater');

  static Future<void> installApk(String filePath) async {
    await _channel.invokeMethod('installApk', {'path': filePath});
  }
}
