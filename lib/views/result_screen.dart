import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  final String resultsString;

  const ResultScreen({super.key, required this.resultsString});

  @override
  Widget build(BuildContext context) {
    final results = resultsString;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).result_list),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(results), // Display the results string directly
            ],
          ),
        ),
      ),
    );
  }
}
