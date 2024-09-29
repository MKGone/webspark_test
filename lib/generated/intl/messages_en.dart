// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "error_empty_field":
            MessageLookupByLibrary.simpleMessage("Empty field"),
        "error_label":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "error_url": MessageLookupByLibrary.simpleMessage("Invalid URL format"),
        "finish_label": MessageLookupByLibrary.simpleMessage(
            "All calculations has finished, you can send your results to server"),
        "hint_text":
            MessageLookupByLibrary.simpleMessage("Send results to server"),
        "home_screen_appbar":
            MessageLookupByLibrary.simpleMessage("Home Screen"),
        "home_screen_title": MessageLookupByLibrary.simpleMessage(
            "Set valid API base URL in order to continue"),
        "preview_screen":
            MessageLookupByLibrary.simpleMessage("Preview screen"),
        "process_screen":
            MessageLookupByLibrary.simpleMessage("Process screen"),
        "result_list":
            MessageLookupByLibrary.simpleMessage("Result list screen"),
        "start_counting":
            MessageLookupByLibrary.simpleMessage("Start counting process")
      };
}
