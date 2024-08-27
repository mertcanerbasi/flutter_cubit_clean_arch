import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_cubit_clean_arch/core/di/dependency_injector.config.dart';

GetIt getIt = GetIt.instance;
@InjectableInit()
Future setupDI(String environment) => getIt.init(environment: environment);
