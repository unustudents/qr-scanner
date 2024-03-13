part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthStInitial extends AuthState {}

final class AuthStLogin extends AuthState {}

final class AuthStLogout extends AuthState {}

final class AuthStLoading extends AuthState {}

final class AuthStError extends AuthState {
  AuthStError({required this.msg});

  final String msg;
}
