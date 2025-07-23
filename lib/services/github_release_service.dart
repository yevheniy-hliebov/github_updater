import 'dart:convert';

import 'package:github_apk_updater/models/github_release_info.dart';
import 'package:http/http.dart' as http;

enum AppVersionMode { stable, beta }

class GithubReleaseService {
  final String apiUrl;
  final String repo;
  final http.Client client;

  GithubReleaseService({this.apiUrl = 'https://api.github.com', required this.repo, http.Client? client})
    : client = client ?? http.Client();

  Future<GitHubReleaseInfo?> fetchLatestRelease({
    AppVersionMode mode = AppVersionMode.stable,
  }) async {
    final response = await client.get(
      Uri.parse('$apiUrl/repos/$repo/releases'),
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode != 200) return null;

    final List<dynamic> releases = jsonDecode(response.body);
    final filtered = releases.where((r) {
      final isPrerelease = r['prerelease'] as bool;
      return mode == AppVersionMode.beta ? isPrerelease : !isPrerelease;
    }).toList();

    if (filtered.isEmpty) return null;

    filtered.toList().sort((a, b) {
      return (b['tag_name'] as String).compareTo(a['tag_name'] as String);
    });

    return GitHubReleaseInfo.fromJson(filtered.first);
  }

  Future<GitHubReleaseInfo?> fetchReleaseByTag(String tag) async {
    final url = '$apiUrl/repos/$repo/releases/tags/$tag';
    final response = await client.get(
      Uri.parse(url),
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode != 200) return null;

    final json = jsonDecode(response.body);
    return GitHubReleaseInfo.fromJson(json);
  }
}
