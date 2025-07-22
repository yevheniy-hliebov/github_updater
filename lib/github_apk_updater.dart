library;

import 'package:flutter/services.dart';
import 'package:github_apk_updater/services/github_apk_downloader.dart';
import 'package:github_apk_updater/services/github_release_service.dart';

export 'package:github_apk_updater/services/github_apk_downloader.dart';
export 'package:github_apk_updater/services/github_release_service.dart';
export 'package:github_apk_updater/models/github_release_info.dart';

class GithubApkUpdater {
  final GitHubApkDownloader _apkDownloader;
  final GithubReleaseService _releaseService;

  GithubApkUpdater({
    required String repo,
    GitHubApkDownloader? apkDownloader,
    GithubReleaseService? releaseService,
  }) : _apkDownloader = apkDownloader ?? GitHubApkDownloader(),
       _releaseService = releaseService ?? GithubReleaseService(repo: repo);

  GitHubApkDownloader get apkDownloader => _apkDownloader;
  GithubReleaseService get releaseService => _releaseService;

  static const MethodChannel _channel = MethodChannel('flutter_app_updater');

  Future<void> installApk(String filePath) async {
    await _channel.invokeMethod('installApk', {'path': filePath});
  }
}
