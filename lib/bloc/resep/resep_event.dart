part of 'resep_bloc.dart';

@immutable
abstract class ResepEvent {}

class ResepGetListEvent extends ResepEvent {
  final bool refresh;

  ResepGetListEvent({this.refresh = false});
}

class ResepTambahEvent extends ResepEvent {
  final Map<String, dynamic> json;

  ResepTambahEvent(this.json);
}

class ResepEditEvent extends ResepEvent {
  final Map<String, dynamic> json;
  ResepEditEvent(this.json);
}

class ResepDeleteEvent extends ResepEvent {
  final int id;

  ResepDeleteEvent(this.id);
}

class ResepGetEvent extends ResepEvent {
  final int id;

  ResepGetEvent(this.id);
}

class ResepSetStatusEvent extends ResepEvent {
  final int id;
  final int status;

  ResepSetStatusEvent(this.id, this.status);
}
