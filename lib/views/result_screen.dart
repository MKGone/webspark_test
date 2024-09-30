import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webspark_test/theme/theme.dart';
import 'package:webspark_test/views/preview_screen.dart';
import '../generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  final String resultsString;
  final List<dynamic> lockedCells;

  const ResultScreen(
      {super.key, required this.resultsString, required this.lockedCells});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> cells = lockedCells;
    final List<dynamic> results = jsonDecode(resultsString);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).result_list),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            final path = result['result']['path'];
            return ListTile(
              title: Text(
                path,
                textAlign: TextAlign.center,
                style: lightTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewPage(
                        result: result,
                        lockedCells: cells,
                      ),
                    ),
                  );
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
