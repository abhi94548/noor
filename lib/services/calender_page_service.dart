import 'package:dio/dio.dart';
import 'package:noor/models/calender_model.dart';
import '../helpers/error_handler.dart';
import '../config.dart';
import '../helpers/http_service.dart';

class CalenderPageService {
  final HttpService httpService = HttpService();

  Future<List<CalenderModel>> fetch() async {
    try {
      final Response<dynamic> response = await httpService.requestSource(
          AppConfig().apiUrl + '/calender.php', 'POST');
      var json = response.data as Map<String, dynamic>;
      var res = json['data'] as List;
      List<CalenderModel> _list = res
          .map<CalenderModel>((json) => CalenderModel.fromJson(json))
          .toList();
      return _list;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('Something went wrong');
      }
    }
  }
}
