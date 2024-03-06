part of 'admin_bloc.dart';

abstract class AdminState {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoginSuccess extends AdminState {}

class AdminLoginFailure extends AdminState {
  final String error;

  const AdminLoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
