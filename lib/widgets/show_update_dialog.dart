import 'package:flutter/material.dart';
import 'package:github_updater/github_apk_updater.dart';
import 'package:github_updater/widgets/no_new_updates_found_dialog.dart';
import 'package:github_updater/widgets/release_info_dialog.dart';

void showUpdateDialog(
  BuildContext context, {
  String? currentVersion,
  String? ignoredVersion,
  required GithubUpdater apkUpdater,
  void Function(GitHubReleaseInfo releaseInfo)? onUpdate,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  final data = await apkUpdater.fetchLatestRelease();

  if (context.mounted) {
    Navigator.of(context).pop();
  }

  if (data?.tagName == ignoredVersion) {
    return;
  }

  if ((data == null || data.tagName == currentVersion) && context.mounted) {
    showDialog(context: context, builder: (_) => NoNewUpdatesFoundDialog());
  }

  if (data != null && context.mounted) {
    final result = await showDialog<ReleaseInfoDialogAnswer>(
      context: context,
      builder: (_) => ReleaseInfoDialog(releaseInfo: data),
    );

    if (result == ReleaseInfoDialogAnswer.update) {
      onUpdate?.call(data);
    }
  }
}
