class GitHubAssetInfo {
  final String name;
  final String contentType;
  final String createdAt;
  final String publishedAt;
  final String browserDownloadUrl;
  final String fileExtensions;

  const GitHubAssetInfo({
    required this.name,
    required this.contentType,
    required this.createdAt,
    required this.publishedAt,
    required this.browserDownloadUrl,
    required this.fileExtensions,
  });

  factory GitHubAssetInfo.fromJson(Map<String, dynamic> json) {
    final name = json['name'].toString();
    final hasExtension = name.contains('.');
    final extension = hasExtension ? '.${name.split('.').last}' : '';

    return GitHubAssetInfo(
      name: name,
      contentType: json['content_type'] as String,
      createdAt: json['created_at'] as String,
      publishedAt: json['updated_at'] as String,
      browserDownloadUrl: json['browser_download_url'] as String,
      fileExtensions: extension,
    );
  }
}
