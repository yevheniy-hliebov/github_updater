package com.example.github_apk_updater

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class GithubApkUpdaterPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    val channel = MethodChannel(binding.binaryMessenger, "flutter_app_updater")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "installApk") {
      val filePath = call.argument<String>("path")
      if (filePath != null) {
        installApk(filePath)
        result.success(true)
      } else {
        result.error("NO_PATH", "APK file path is null", null)
      }
    } else {
      result.notImplemented()
    }
  }

  private fun installApk(filePath: String) {
    val file = File(filePath)
    if (!file.exists()) return

    val apkUri = FileProvider.getUriForFile(
      context,
      "${context.packageName}.fileprovider",
      file
    )

    val intent = Intent(Intent.ACTION_VIEW).apply {
      setDataAndType(apkUri, "application/vnd.android.package-archive")
      flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_GRANT_READ_URI_PERMISSION
    }

    context.startActivity(intent)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
}
