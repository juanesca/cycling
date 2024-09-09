import 'package:app/core/domain/datasources/auth.datasource.dart';
import 'package:app/infrastructure/di/http.dart';

class AuthDatasource implements IAuthDatasource {
  @override
  Future<String> login(String email, String password) async {
    return 'smth';
    final res = await CHttp.instance.client
        .post('/auth/login', data: {'email': email, 'password': password});
    return res.data ??'true';
  }

  @override
  Future<String> signup(
      {required String name, required String email, required String password}) async {
    return 'smth';

    final res = await CHttp.instance.client.post('/auth/signup',
        data: {'name': name, 'email': email, 'password': password});
    return res.data??'true';
  }
}
