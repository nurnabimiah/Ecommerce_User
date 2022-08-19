import 'package:flutter/material.dart';

class CustomProgressDialog extends StatelessWidget {
  final String title;
  const CustomProgressDialog(this.title);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      contentPadding: const EdgeInsets.all(8),
      content: const SizedBox(
        height: 100,
          child: Center(child: CircularProgressIndicator()
          )
      ),
    );
  }
}
