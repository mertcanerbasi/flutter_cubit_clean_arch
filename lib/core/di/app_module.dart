import 'package:dio/dio.dart';
import 'package:flutter_cubit_clean_arch/core/interceptor/log_interceptor.dart';
import 'package:flutter_cubit_clean_arch/core/interceptor/token_interceptor.dart';
import 'package:flutter_cubit_clean_arch/features/data/api/character_api_service.dart';
import 'package:injectable/injectable.dart';
import 'package:get_storage/get_storage.dart';

@module
abstract class AppModule {
  @Environment(Environment.prod)
  @Environment(Environment.dev)
  @preResolve
  Future<GetStorage> get storage async {
    await GetStorage.init("MyStorage");
    return GetStorage("MyStorage");
  }

  @lazySingleton
  Dio get injectRetrofitAPI {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://rickandmortyapi.com/api",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        connectTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      ),
    );

    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(LoggerInterceptor());

    return dio;
  }

  @lazySingleton
  CharacterApiService get characterApiService =>
      CharacterApiService(injectRetrofitAPI);
}
