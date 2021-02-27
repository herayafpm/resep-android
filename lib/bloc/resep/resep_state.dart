part of 'resep_bloc.dart';

@immutable
abstract class ResepState {}

class ResepInitial extends ResepState {}

class ResepStateLoading extends ResepState {}

class ResepStateSuccess extends ResepState {
  final Map<String, dynamic> data;

  ResepStateSuccess(this.data);
}

class ResepFormSuccess extends ResepState {
  final Map<String, dynamic> data;

  ResepFormSuccess(this.data);
}

class ResepStateError extends ResepState {
  final Map<String, dynamic> errors;

  ResepStateError(this.errors);
}

class ResepListLoaded extends ResepState {
  List<dynamic> reseps;
  bool hasReachMax;

  ResepListLoaded({this.reseps, this.hasReachMax});
  ResepListLoaded copyWith({List<dynamic> reseps, bool hasReachMax}) {
    return ResepListLoaded(
        reseps: reseps ?? this.reseps,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }
}
