import 'package:flutter/material.dart';

class CheckForUpdateTile extends StatelessWidget {
  final void Function()? onTap;

  const CheckForUpdateTile({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('Check For Update'), onTap: onTap);
  }
}
