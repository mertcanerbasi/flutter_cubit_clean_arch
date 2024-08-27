// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_cubit_clean_arch/core/di/app_module.dart' as _i763;
import 'package:flutter_cubit_clean_arch/features/data/api/character_api_service.dart'
    as _i79;
import 'package:flutter_cubit_clean_arch/features/data/local_datasource/local_datasource.dart'
    as _i370;
import 'package:flutter_cubit_clean_arch/features/data/repositories/character_repository.dart'
    as _i829;
import 'package:flutter_cubit_clean_arch/features/presentation/cubit/character_cubit/character_cubit.dart'
    as _i469;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;

const String _prod = 'prod';
const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i361.Dio>(() => appModule.injectRetrofitAPI);
    gh.lazySingleton<_i79.CharacterApiService>(
        () => appModule.characterApiService);
    await gh.factoryAsync<_i792.GetStorage>(
      () => appModule.storage,
      registerFor: {
        _prod,
        _dev,
      },
      preResolve: true,
    );
    gh.lazySingleton<_i829.CharacterRepository>(
        () => _i829.CharacterRepositoryImpl(gh<_i79.CharacterApiService>()));
    gh.lazySingleton<_i370.LocalDataSource>(
      () => _i370.LocalDataSourceImpl(gh<_i792.GetStorage>()),
      registerFor: {
        _prod,
        _dev,
      },
    );
    gh.factory<_i469.CharacterCubit>(() =>
        _i469.CharacterCubit(repository: gh<_i829.CharacterRepository>()));
    return this;
  }
}

class _$AppModule extends _i763.AppModule {}
