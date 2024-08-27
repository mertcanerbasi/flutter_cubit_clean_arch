// Package imports:
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cubit_clean_arch/core/utils/aes_encrypt/aes_encrypt_model.dart';
import 'package:flutter_cubit_clean_arch/core/utils/logger.dart';

// Project imports:

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var timestamp = "${DateTime.now().millisecondsSinceEpoch}";
    options.headers["timestamp"] = timestamp;

    Log.i("""--> 
    START REQUEST
    ${options.method} ${options.baseUrl}${options.path} 
    Content type: ${options.contentType}
    QueryParameters : ${options.queryParameters}
    Headers : ${options.headers}
    Data : ${_printData(options.data, options.headers["encrypted"] == true)}
    
    <-- END REQUEST""", tag: timestamp);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d("""--> 
    START RESPONSE
    Time ${DateTime.now().millisecondsSinceEpoch - int.parse(response.requestOptions.headers["timestamp"])} ms
    ${response.requestOptions.method} - ${response.requestOptions.baseUrl}${response.requestOptions.path} - ${response.statusCode}
    ${_getData(response)}
    <-- END RESPONSE""",
        tag: response.requestOptions.headers["timestamp"].toString());

    return super.onResponse(response, handler);
  }

  String? _getData(Response response) {
    if (response.statusCode == 200) {
      return _printData(
          response.data, response.requestOptions.headers["encrypted"] == true);
    }
    return null;
  }

  String? _printData(dynamic data, bool encrypted) {
    if (encrypted) {
      try {
        final value = AesEncryptModel<dynamic>.fromJson(
          data,
          (json) => json as dynamic,
        );
        print("Body ${const JsonEncoder.withIndent('  ').convert(value.data)}");
        return "${const JsonEncoder.withIndent('  ').convert(value.data)}\n\nencrypted: \n\n$data";
      } catch (e) {
        return const JsonEncoder.withIndent('  ').convert(data).toString();
      }
    } else {
      return const JsonEncoder.withIndent('  ').convert(data).toString();
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.e("""--> 
    START ERROR
    Time ${DateTime.now().millisecondsSinceEpoch - int.parse(err.response?.requestOptions.headers["timestamp"] ?? "0")} ms
    ${err.type}
    ${err.requestOptions.method} - ${err.requestOptions.baseUrl}${err.requestOptions.path} - ${err.response?.statusCode}
    ${err.requestOptions.headers}
    ${_printData(err.requestOptions.data, err.response?.requestOptions.headers["encrypted"] == true)}
    ${err.response?.data.toString().trim()}
      Data : ${_printData(err.response?.data, err.requestOptions.headers["encrypted"] == true)}
    <-- END ERROR""", tag: err.requestOptions.headers["timestamp"].toString());

    return super.onError(err, handler);
  }
}
