import 'package:app/common/http_client.dart';
import 'package:app/data/auth_info.dart';
import 'package:app/data/source/auth_data_source.dart';
import 'package:flutter/cupertino.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  static var authChangeNotifier;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    debugPrint("access token is: " + authInfo.accessToken);
  }

  void loadAuthInfo() {}
}
