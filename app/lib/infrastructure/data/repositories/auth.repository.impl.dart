import 'package:app/core/domain/datasources/auth.datasource.dart';
import 'package:app/core/domain/repositories/auth.repository.dart';
import 'package:app/infrastructure/data/datasources/auth.datasource.impl.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDatasource datasource;

  AuthRepository() : datasource = AuthDatasource();

  @override
  Future<String> login(String email, String password) async {
    return await datasource.login(email, password);
  }

  @override
  Future<String> signup(
      {required String name,
      required String email,
      required String password}) async {
    return await datasource.signup(
        name: name, email: email, password: password);
  }
}
