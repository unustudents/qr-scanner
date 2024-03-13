part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthEvLogin extends AuthEvent {
  AuthEvLogin({required this.email, required this.pass});
  final String email;
  final String pass;
}

class AuthEvLogout extends AuthEvent {}
