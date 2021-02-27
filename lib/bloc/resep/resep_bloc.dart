import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resep/repositories/resep_repository.dart';

part 'resep_event.dart';
part 'resep_state.dart';

class ResepBloc extends Bloc<ResepEvent, ResepState> {
  ResepBloc() : super(ResepInitial());

  @override
  Stream<ResepState> mapEventToState(
    ResepEvent event,
  ) async* {
    if (event is ResepGetListEvent) {
      int limit = 10;
      List<dynamic> reseps = [];
      if (state is ResepInitial || event.refresh) {
        Map<String, dynamic> res =
            await ResepRepository.getListResep(limit: limit, offset: 0);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<dynamic>;
          reseps = jsonObject;
          yield ResepListLoaded(reseps: reseps, hasReachMax: false);
        } else if (res['statusCode'] == 400) {
          yield ResepStateError(res['data']);
        } else {
          yield ResepStateError(res['data']);
        }
      } else if (state is ResepListLoaded) {
        ResepListLoaded resepListLoaded = state as ResepListLoaded;
        Map<String, dynamic> res = await ResepRepository.getListResep(
            limit: limit, offset: resepListLoaded.reseps.length);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<Map<String, dynamic>>;
          if (jsonObject.length == 0) {
            yield resepListLoaded.copyWith(hasReachMax: true);
          } else {
            reseps = jsonObject;
            yield ResepListLoaded(
                reseps: resepListLoaded.reseps + reseps, hasReachMax: false);
          }
        } else if (res['statusCode'] == 400) {
          yield ResepStateError(res['data']);
        } else {
          yield ResepStateError(res['data']);
        }
      }
    }
  }
}
