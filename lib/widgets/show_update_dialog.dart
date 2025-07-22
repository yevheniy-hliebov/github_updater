import 'package:flutter/material.dart';
import 'package:github_apk_updater/github_apk_updater.dart';
import 'package:github_apk_updater/widgets/no_new_updates_found_dialog.dart';
import 'package:github_apk_updater/widgets/release_info_dialog.dart';

void showUpdateDialog(
  BuildContext context, {
  String? currentVersion,
  required GithubApkUpdater apkUpdater,
  void Function()? onUpdate,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  final data = await apkUpdater.releaseService.fetchLatestRelease();

  if (context.mounted) {
    Navigator.of(context).pop();
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
      onUpdate?.call();
    }
  }
}
