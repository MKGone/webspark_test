import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
part 'process_state.dart';
part 'process_event.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  final String apiUrl;

  ProcessBloc(this.apiUrl) : super(ProcessInitial()) {
    on<PostResults>((event, emit) async {
      emit(ProcessLoading());

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: event.results,
        );

        if (response.statusCode == 200) {
          emit(ProcessSuccess(response.body));
        } else {
          emit(
              ProcessFailure("Failed to post results: ${response.statusCode}"));
        }
      } catch (e) {
        emit(ProcessFailure(e.toString()));
      }
    });
  }
}
