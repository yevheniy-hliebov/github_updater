import 'package:github_apk_updater/models/github_asset_info.dart';

export 'package:github_apk_updater/models/github_asset_info.dart';

class GitHubReleaseInfo {
  final String url;
  final String name;
  final String tagName;
  final String body;
  final bool draft;
  final bool prerelease;
  final String createdAt;
  final String publishedAt;
  final List<GitHubAssetInfo> assets;

  const GitHubReleaseInfo({
    required this.url,
    required this.name,
    required this.tagName,
    required this.body,
    required this.draft,
    required this.prerelease,
    required this.createdAt,
    required this.publishedAt,
    required this.assets,
  });

  factory GitHubReleaseInfo.fromJson(Map<String, dynamic> json) {
    final assetsJson = json['assets'] as List<dynamic>? ?? [];

    return GitHubReleaseInfo(
      url: json['url'] as String,
      name: json['name'] as String,
      tagName: json['tag_name'] as String,
      body: json['body'] as String,
      draft: json['draft'] as bool,
      prerelease: json['prerelease'] as bool,
      createdAt: json['created_at'] as String,
      publishedAt: json['published_at'] as String,
      assets: assetsJson
          .map((e) => GitHubAssetInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
