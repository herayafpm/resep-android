import 'dart:io';

import 'package:dio/dio.dart';
import 'package:resep/services/dio_service.dart';
import 'package:resep/utils/response_util.dart';

abstract class ResepRepository {
  static Future<Map<String, dynamic>> getListResep(
      {int limit = 10, int offset = 0}) async {
    try {
      Dio dio = DioService.init();
      Response response = await dio.get("/resep?limit=$limit&offset=$offset");
      Map<String, dynamic> data = Map<String, dynamic>();
      data['statusCode'] = response.statusCode;
      data['data'] = response.data;
      return data;
    } on SocketException catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.message);
    } on DioError catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.message);
    } catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.toString());
    }
  }
}
