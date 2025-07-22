import 'package:flutter/material.dart';

class NoNewUpdatesFoundDialog extends StatelessWidget {
  const NoNewUpdatesFoundDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text(
        'No new updates',
      ),
      content: Text(
        'No new updates found.',
      ),
    );
  }
}
