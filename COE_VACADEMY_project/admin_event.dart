part of 'admin_bloc.dart';

abstract class AdminEvent {}

class AdminLoginButtonPressed extends AdminEvent {
  final String username;
  final String password;

  AdminLoginButtonPressed({required this.username, required this.password});
}
