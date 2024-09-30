import 'package:flutter/material.dart';
import 'package:webspark_test/utils/constants.dart';
import '../generated/l10n.dart';

class PreviewPage extends StatelessWidget {
  final dynamic result;
  final List<dynamic> lockedCells;

  const PreviewPage(
      {super.key, required this.result, required this.lockedCells});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> steps = result['result']['steps'];
    final String path = result['result']['path'];
    const int gridSize = 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).preview_screen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                int x = index % gridSize;
                int y = index ~/ gridSize;

                bool isStep =
                    steps.any((step) => step['x'] == '$x' && step['y'] == '$y');
                int stepIndex = steps.indexWhere(
                    (step) => step['x'] == '$x' && step['y'] == '$y');
                bool isLockedCell =
                    lockedCells.any((cell) => cell['x'] == x && cell['y'] == y);

                Color cellColor;

                if (isLockedCell) {
                  cellColor = black;
                } else if (stepIndex == 0) {
                  cellColor = startCell;
                } else if (stepIndex == steps.length - 1) {
                  cellColor = endCell;
                } else if (isStep) {
                  cellColor = shortCell;
                } else {
                  cellColor = background;
                }

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: black),
                    color: cellColor,
                  ),
                  child: Center(
                    child: isLockedCell
                        ? Text(
                            '($x,$y)',
                            style: const TextStyle(color: background),
                          )
                        : Text('($x,$y)'),
                  ),
                );
              },
            ),
            Center(
              child: Text(
                path,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
