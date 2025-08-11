import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class GitHubDownloader {
  final http.Client client;
  final _downloadProgressController = StreamController<int?>.broadcast();

  Stream<int?> get downloadProgressStream => _downloadProgressController.stream;
  bool _isDownloading = false;

  GitHubDownloader({http.Client? client}) : client = client ?? http.Client();

  Future<void> start(String url, String savePath) async {
    if (_isDownloading) return;
    _isDownloading = true;

    final uri = Uri.parse(url);
    final request = http.Request('GET', uri);
    final response = await client.send(request);

    if (response.statusCode != 200) {
      _isDownloading = false;
      throw Exception('Failed to download');
    }

    final contentLength = response.contentLength ?? 0;
    final file = File(savePath);
    final sink = file.openWrite();

    int bytesReceived = 0;
    await for (final chunk in response.stream) {
      bytesReceived += chunk.length;
      sink.add(chunk);

      if (contentLength > 0) {
        final progress = (bytesReceived / contentLength * 100).toInt();
        _downloadProgressController.add(progress);
      }
    }

    await sink.close();
    _downloadProgressController.add(100);
    _isDownloading = false;
  }
}
