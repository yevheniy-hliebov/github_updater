library;

import 'package:flutter/services.dart';
import 'package:github_updater/models/github_release_info.dart';
import 'package:github_updater/services/github_downloader.dart';
import 'package:github_updater/services/github_release_service.dart';

export 'package:github_updater/services/github_downloader.dart';
export 'package:github_updater/services/github_release_service.dart';
export 'package:github_updater/models/github_release_info.dart';

class GithubUpdater {
  final GitHubDownloader _downloader;
  final GithubReleaseService _releaseService;

  GithubUpdater({
    required String repo,
    String apiUrl = 'https://api.github.com',
    GitHubDownloader? downloader,
    GithubReleaseService? releaseService,
  }) : _downloader = downloader ?? GitHubDownloader(),
       _releaseService =
           releaseService ?? GithubReleaseService(repo: repo, apiUrl: apiUrl);

  GitHubDownloader get downloader => _downloader;

  Future<GitHubReleaseInfo?> fetchLatestRelease({
    AppVersionMode mode = AppVersionMode.stable,
  }) async => _releaseService.fetchLatestRelease(mode: mode);

  Future<GitHubReleaseInfo?> fetchReleaseByTag(String tag) async =>
      _releaseService.fetchReleaseByTag(tag);

  static const MethodChannel _channel = MethodChannel('flutter_app_updater');

  Future<void> installApk(String filePath) async {
    await _channel.invokeMethod('installApk', {'path': filePath});
  }
}
