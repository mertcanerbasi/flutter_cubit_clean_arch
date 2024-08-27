// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_cubit_clean_arch/core/di/dependency_injector.dart';
import 'package:flutter_cubit_clean_arch/features/data/local_datasource/local_datasource.dart';

//https://github.com/flutterchina/dio
class TokenInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var localDataSource = getIt<LocalDataSource>();
    if (localDataSource.isLogin) {
      options.headers["Authorization"] = "Bearer xxxxx";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      var localDataSource = getIt<LocalDataSource>();
      localDataSource.clean();
    }
    super.onError(err, handler);
  }
}
