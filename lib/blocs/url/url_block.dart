import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webspark_test/blocs/url/url_event.dart';
import 'package:webspark_test/blocs/url/url_state.dart';

class UrlBloc extends Bloc<UrlEvent, UrlState> {
  UrlBloc() : super(UrlInitial()) {
    on<UrlChanged>((event, emit) {
      final isValid = _validateUrl(event.url);
      if (isValid) {
        emit(UrlValid());
      } else {
        emit(UrlInvalid("Invalid URL"));
      }
    });

    on<ValidateUrl>((event, emit) async {
      final isValid = _validateUrl(event.url);
      if (isValid) {
        emit(UrlValid());
        await _saveUrl(event.url);
        add(FetchUrlData(event.url));
      } else {
        emit(UrlInvalid("Invalid URL"));
      }
    });

    on<FetchUrlData>((event, emit) async {
      emit(UrlLoading());
      try {
        final response = await http.get(Uri.parse(event.url));
        if (response.statusCode == 200) {
          emit(UrlFetchSuccess(response.body));
        } else {
          emit(UrlFetchFailure('Failed to load data: ${response.statusCode}'));
        }
      } catch (e) {
        emit(UrlFetchFailure(e.toString()));
      }
    });
  }

  bool _validateUrl(String url) {
    const urlPattern = r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$";
    final regex = RegExp(urlPattern);
    return regex.hasMatch(url);
  }

  Future<void> _saveUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_url', url);
  }
}
