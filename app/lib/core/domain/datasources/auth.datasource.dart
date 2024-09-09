abstract class IAuthDatasource {
  Future<String> login(String email, String password);
  Future<String> signup({required String name, required String email, required String password});
}