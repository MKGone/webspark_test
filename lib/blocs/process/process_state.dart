part of 'process_bloc.dart';

abstract class ProcessState {}

class ProcessInitial extends ProcessState {}

class ProcessLoading extends ProcessState {}

class ProcessSuccess extends ProcessState {
  final String message;

  ProcessSuccess(this.message);
}

class ProcessResultsPosted extends ProcessState {}

class ProcessResultsError extends ProcessState {
  final String message;

  ProcessResultsError(this.message);
}

class ProcessFailure extends ProcessState {
  final String error;

  ProcessFailure(this.error);
}
