import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestServ {
  static const String baseUrl = "https://fakestoreapi.com";
  static const String urlProduct = "/products";


  RequestServ._privateConstructor();
  static final RequestServ instance = RequestServ._privateConstructor();

  Future<String?> handlingRequest({
    required String urlParam,
    Map<String, dynamic>? params,
    String method = "GET",
    bool asJson = false,
  }) async {
    try {

      String fullUrl = baseUrl + urlParam;

      Uri uri;

      if (method.toUpperCase() == 'GET' && params != null && params.isNotEmpty) {
        uri = Uri.parse(fullUrl).replace(queryParameters: params);
      } else {
        uri = Uri.parse(fullUrl);
      }
      print("=> ${uri}");
      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await http
              .get(uri)
              .timeout(const Duration(seconds: 10));
          break;

        case 'POST':
          response = await http
              .post(uri, body: _buildBody(params, asJson), headers: _buildHeaders(asJson))
              .timeout(const Duration(seconds: 10));
          break;

        case 'PUT':
          response = await http
              .put(uri, body: _buildBody(params, asJson), headers: _buildHeaders(asJson))
              .timeout(const Duration(seconds: 10));
          break;

        case 'PATCH':
          response = await http
              .patch(uri, body: _buildBody(params, asJson), headers: _buildHeaders(asJson))
              .timeout(const Duration(seconds: 10));
          break;

        case 'DELETE':
          response = await http
              .delete(uri, body: _buildBody(params, asJson), headers: _buildHeaders(asJson))
              .timeout(const Duration(seconds: 10));
          break;

        default:
          throw UnsupportedError("HTTP method $method no soportado");
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        print("HTTP error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error en handlingRequest: $e");
      return null;
    }
  }


  /// Función genérica para parsear JSON a objeto
  Future<T?> handlingRequestParsed<T>(
      {required String urlParam,
        Map<String, dynamic>? params,
        String method = "GET",
        bool asJson = false,
        required T Function(dynamic json) fromJson}) async {
    final responseString = await handlingRequest(
        urlParam: urlParam, params: params, method: method, asJson: asJson);

    if (responseString == null) return null;

    try {
      final jsonMap = jsonDecode(responseString);
      return fromJson(jsonMap);
    } catch (e) {
      print("Error parseando JSON: $e");
      return null;
    }
  }

  dynamic _buildBody(Map<String, dynamic>? params, bool asJson) {
    if (params == null) return null;
    return asJson ? jsonEncode(params) : params.map((k, v) => MapEntry(k, v.toString()));
  }

  Map<String, String>? _buildHeaders(bool asJson) {
    return asJson ? {'Content-Type': 'application/json'} : null;
  }


}