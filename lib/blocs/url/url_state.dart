abstract class UrlState {}

class UrlInitial extends UrlState {}

class UrlValid extends UrlState {}

class UrlInvalid extends UrlState {
  final String errorMessage;

  UrlInvalid(this.errorMessage);
}

class UrlLoading extends UrlState {}

class UrlFetchSuccess extends UrlState {
  final String data;

  UrlFetchSuccess(this.data);
}

class UrlFetchFailure extends UrlState {
  final String error;

  UrlFetchFailure(this.error);
}
