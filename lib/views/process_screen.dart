import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webspark_test/theme/theme.dart';
import 'package:webspark_test/views/result_screen.dart';
import '../utils/process_data.dart';
import '../generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/process/process_bloc.dart';

class ProcessScreen extends StatefulWidget {
  final String jsonResponse;

  const ProcessScreen({super.key, required this.jsonResponse});

  @override
  ProcessScreenState createState() => ProcessScreenState();
}

class ProcessScreenState extends State<ProcessScreen> {
  bool _isLoading = true;
  bool _isPosting = false;
  double _progress = 0.0;
  String _statusMessage = "";
  String? _errorMessage;
  List<Map<String, dynamic>> _results = [];
  late ProcessBloc _processBloc;
  List<dynamic> lockedCells = [];

  @override
  void initState() {
    super.initState();
    _processData();
  }

  Future<void> _processData() async {
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _progress = i / 100;
        _statusMessage = "$i%";
      });
    }
    final Map<String, dynamic> responseData = jsonDecode(widget.jsonResponse);
    if (responseData['error'] == false) {
      for (var item in responseData['data']) {
        List<String> field = List<String>.from(item['field']);

        for (int rowIndex = 0; rowIndex < field.length; rowIndex++) {
          String row = field[rowIndex];
          for (int colIndex = 0; colIndex < row.length; colIndex++) {
            if (row[colIndex] == 'X') {
              lockedCells.add({'x': colIndex, 'y': rowIndex});
            }
          }
        }
      }
    }

    _results = processApiResponse(widget.jsonResponse);
    setState(() {
      _isLoading = false;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('saved_url');
    if (url != null) {
      _processBloc = ProcessBloc(url);
    } else {
      if (kDebugMode) {
        print("URL not found in shared preferences");
      }
    }
  }

  void _postResults() async {
    List<Map<String, dynamic>> formattedResults = _results.map((result) {
      return {
        'id': result['id'],
        'result': {
          'steps': result['result']['steps'],
          'path': result['result']['path'],
        }
      };
    }).toList();

    String resultsString = jsonEncode(formattedResults);

    setState(() {
      _isPosting = true;
      _errorMessage = null;
    });

    _processBloc.add(PostResults(resultsString));
    _processBloc.stream.listen((state) {
      if (state is ProcessSuccess) {
        setState(() {
          _isPosting = false;
          _errorMessage = null;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              resultsString: resultsString,
              lockedCells: lockedCells,
            ),
          ),
        );
      } else if (state is ProcessFailure) {
        setState(() {
          _isPosting = false;
          _errorMessage = state.error;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).process_screen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _statusMessage,
                            style: lightTheme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              value: _progress,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).finish_label,
                          textAlign: TextAlign.center,
                          style: lightTheme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _statusMessage,
                          style: lightTheme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: _progress,
                          ),
                        ),
                      ],
                    ),
            ),
            if (!_isLoading && _progress == 1.0) ...[
              if (_isPosting)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              else if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        _postResults();
                      },
                      child: Text(
                        S.of(context).hint_text,
                      ),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
