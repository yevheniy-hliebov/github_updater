import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:github_apk_updater/github_apk_updater.dart';

enum ReleaseInfoDialogAnswer { ignoreVersion, remindMeLater, update }

class ReleaseInfoDialog extends StatelessWidget {
  final GitHubReleaseInfo releaseInfo;
  final BoxConstraints dialogConstraints;
  final BoxConstraints bodyConstraints;

  const ReleaseInfoDialog({
    super.key,
    required this.releaseInfo,
    this.dialogConstraints = const BoxConstraints(
      maxWidth: 500,
      maxHeight: 500,
    ),
    this.bodyConstraints = const BoxConstraints(maxHeight: 200),
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Version Available (${releaseInfo.tagName})'),
      content: ConstrainedBox(
        constraints: dialogConstraints,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (releaseInfo.prerelease)
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'This is a beta release.',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              if (releaseInfo.body.isNotEmpty)
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  constraints: bodyConstraints,
                  child: Markdown(
                    padding: EdgeInsets.zero,
                    data: releaseInfo.body,
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(ReleaseInfoDialogAnswer.ignoreVersion);
          },
          child: const Text('Ignore this version'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(ReleaseInfoDialogAnswer.remindMeLater);
          },
          child: const Text('Remind me later'),
        ),
        FilledButton(
          onPressed: () async {
            Navigator.of(context).pop(ReleaseInfoDialogAnswer.update);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
