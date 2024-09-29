part of 'process_bloc.dart';

abstract class ProcessEvent {}

class PostResults extends ProcessEvent {
  final String results;

  PostResults(this.results);
}
