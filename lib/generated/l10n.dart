// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home Screen`
  String get home_screen_appbar {
    return Intl.message(
      'Home Screen',
      name: 'home_screen_appbar',
      desc: '',
      args: [],
    );
  }

  /// `Set valid API base URL in order to continue`
  String get home_screen_title {
    return Intl.message(
      'Set valid API base URL in order to continue',
      name: 'home_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Start counting process`
  String get start_counting {
    return Intl.message(
      'Start counting process',
      name: 'start_counting',
      desc: '',
      args: [],
    );
  }

  /// `Invalid URL format`
  String get error_url {
    return Intl.message(
      'Invalid URL format',
      name: 'error_url',
      desc: '',
      args: [],
    );
  }

  /// `Empty field`
  String get error_empty_field {
    return Intl.message(
      'Empty field',
      name: 'error_empty_field',
      desc: '',
      args: [],
    );
  }

  /// `Process screen`
  String get process_screen {
    return Intl.message(
      'Process screen',
      name: 'process_screen',
      desc: '',
      args: [],
    );
  }

  /// `All calculations has finished, you can send your results to server`
  String get finish_label {
    return Intl.message(
      'All calculations has finished, you can send your results to server',
      name: 'finish_label',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get error_label {
    return Intl.message(
      'Something went wrong',
      name: 'error_label',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'send results' key

  // skipped getter for the 'send results1' key

  /// `Result list screen`
  String get result_list {
    return Intl.message(
      'Result list screen',
      name: 'result_list',
      desc: '',
      args: [],
    );
  }

  /// `Preview screen`
  String get preview_screen {
    return Intl.message(
      'Preview screen',
      name: 'preview_screen',
      desc: '',
      args: [],
    );
  }

  /// `Send results to server`
  String get hint_text {
    return Intl.message(
      'Send results to server',
      name: 'hint_text',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
