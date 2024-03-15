import 'package:api_application/helpers/http_response.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AuthenticationAPI {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<HttpResponse> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'http://192.168.0.98:9000/api/v1/register',
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
      );
      _logger.i(response.data);

      return HttpResponse.success(response.data);
    } catch (e) {
      _logger.e(e);
      int? statusCode = -1;
      String? message = 'Unknown error';
      dynamic data;
      if (e is DioException) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode;
          message = e.response!.statusMessage;
          data = e.response!.data;
        }
      }
      return HttpResponse.failure(
        statusCode: statusCode!,
        message: message!,
        data: data,
      );
    }
  }

  Future<HttpResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'http://192.168.0.98:9000/api/v1/login',
        data: {
          "email": email,
          "password": password,
        },
      );
      _logger.i(response.data);

      return HttpResponse.success(response.data);
    } catch (e) {
      _logger.e(e);
      int? statusCode = -1;
      String? message = 'Unknown error';
      dynamic data;
      if (e is DioException) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode;
          message = e.response!.statusMessage;
          data = e.response!.data;
        }
      }
      return HttpResponse.failure(
        statusCode: statusCode!,
        message: message!,
        data: data,
      );
    }
  }
}
