import 'package:api_application/helpers/http.dart';
import 'package:api_application/helpers/http_response.dart';
import 'package:api_application/models/authentication_response.dart';

//'http://192.168.0.98:9000',
class AuthenticationAPI {
  final Http _http;

  AuthenticationAPI(this._http);

  Future<HttpResponse<AuthenticationResponse>> register({
    required String username,
    required String email,
    required String password,
  }) {
    return _http.request<AuthenticationResponse>(
      '/api/v1/register',
      method: 'POST',
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<AuthenticationResponse>> login({
    required String email,
    required String password,
  }) {
    return _http.request<AuthenticationResponse>(
      '/api/v1/login',
      method: 'POST',
      data: {
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }
}
