import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ig/models/models.dart';
import 'package:flutter_ig/repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void loginWithCredentials() async {
    if (state.status == LoginStatus.submitting || !state.isFormValid) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      // _authRepository.loginwithemailandpassword()
      await _authRepository.logInWithEmailAndPassword(
          email: state.email, password: state.password);
      emit(state.copyWith(status: LoginStatus.success));
    } on Failure catch (err) {
      emit(state.copyWith(
          failure: Failure(code: err.code, message: err.message),
          status: LoginStatus.error));
    }
  }
}
