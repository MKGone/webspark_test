abstract class UrlEvent {}

class UrlChanged extends UrlEvent {
  final String url;

  UrlChanged(this.url);
}

class ValidateUrl extends UrlEvent {
  final String url;

  ValidateUrl(this.url);
}

class FetchUrlData extends UrlEvent {
  final String url;

  FetchUrlData(this.url);
}
