import 'dart:collection';
import 'dart:convert';

class Position {
  int x;
  int y;

  Position(this.x, this.y);
}

List<Map<String, int>> shortestPath(
    List<String> grid, Position start, Position end) {
  int rows = grid.length;
  int cols = grid[0].length;

  List<List<int>> directions = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1],
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ];

  if (start.x == end.x && start.y == end.y) {
    return [
      {'x': start.x, 'y': start.y}
    ];
  }

  Queue<List<dynamic>> queue = Queue();
  Set<String> visited = {};

  queue.add([
    start,
    [start]
  ]);
  visited.add('${start.x},${start.y}');

  while (queue.isNotEmpty) {
    List<dynamic> current = queue.removeFirst();
    Position pos = current[0];
    List<Position> path = current[1];

    for (List<int> direction in directions) {
      int nx = pos.x + direction[0];
      int ny = pos.y + direction[1];

      if (nx >= 0 &&
          nx < rows &&
          ny >= 0 &&
          ny < cols &&
          grid[nx][ny] == '.' &&
          !visited.contains('$nx,$ny')) {
        if (nx == end.x && ny == end.y) {
          List<Map<String, int>> result = [];
          for (var p in path + [Position(nx, ny)]) {
            result.add({'x': p.x, 'y': p.y});
          }
          return result;
        }

        visited.add('$nx,$ny');
        queue.add([
          Position(nx, ny),
          List<Position>.from(path)..add(Position(nx, ny))
        ]);
      }
    }
  }

  return [];
}

List<Map<String, dynamic>> processApiResponse(String jsonResponse) {
  var data = json.decode(jsonResponse)['data'];
  List<Map<String, dynamic>> results = [];

  for (var entry in data) {
    String id = entry['id'];
    List<String> field = List<String>.from(entry['field']);
    Position start = Position(entry['start']['x'], entry['start']['y']);
    Position end = Position(entry['end']['x'], entry['end']['y']);

    List<Map<String, int>> path = shortestPath(field, start, end);
    List<Map<String, String>> steps = path
        .map((pos) => {'x': pos['x'].toString(), 'y': pos['y'].toString()})
        .toList();
    String pathString =
        path.map((pos) => '(${pos['x']},${pos['y']})').join('->');

    results.add({
      'id': id,
      'result': {
        'steps': steps,
        'path': pathString,
      }
    });
  }

  return results;
}

List<Map<String, dynamic>> processInputData(String inputData) {
  return processApiResponse(inputData);
}
