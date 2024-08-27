import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

abstract class LocalDataSource {
  bool get isLogin;
  Future setEmail(String? email);
  Future clean();
}

@Environment(Environment.prod)
@Environment(Environment.dev)
@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final GetStorage _getStorage;
  LocalDataSourceImpl(this._getStorage);
  @override
  bool get isLogin => _getStorage.read("email") != null;

  @override
  Future setEmail(String? email) {
    return _getStorage.write("email", email);
  }

  @override
  Future clean() {
    return _getStorage.erase();
  }
}
