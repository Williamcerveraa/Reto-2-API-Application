import 'package:api_application/Api/authentication_api.dart';
import 'package:api_application/helpers/http.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.0.98:9000',
      ),
    );
    Logger logger = Logger();
    Http http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true,
    );
    final AuthenticationAPI authenticationAPI = AuthenticationAPI(http);
    GetIt.instance.registerSingleton<AuthenticationAPI>(authenticationAPI);
  }
}