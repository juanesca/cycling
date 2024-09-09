import 'package:app/core/domain/repositories/auth.repository.dart';
import 'package:app/core/utils/preferences.constants.dart';
import 'package:app/core/utils/providers.dart';
import 'package:app/infrastructure/data/repositories/auth.repository.impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authUseCase = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => AuthState();

  IAuthRepository get repo => AuthRepository();

  _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Prefs.token, token);
  }

  login(String email, String password) async {
    try {
      final res = await repo.login(email, password);
      await _saveToken(res);
      state = state.copyWith(token: res);
      ref.read(authStateProvider.notifier).state = true;
    } on DioException catch (e) {
      state = state.copyWith(error: e.message);
      print(e);
    }
  }

  signup({required String name, required String email, required String password}) async {
    try {
      final res = await repo.signup(email: email, name: name, password: password);
      await _saveToken(res);
      state = state.copyWith(token: res);
      ref.read(authStateProvider.notifier).state = true;
    } on DioException catch (e) {
      state = state.copyWith(error: e.message);
      print(e);
    }
  }
}

class AuthState {
  final String token;
  final String? error;

  AuthState({this.token = '', this.error});

  AuthState copyWith({String? token, String? error}) =>
      AuthState(token: token ?? this.token, error: error);
}
