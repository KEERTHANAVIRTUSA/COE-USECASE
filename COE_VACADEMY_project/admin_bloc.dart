import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial());

  @override
  Stream<AdminState> mapEventToState(
    AdminEvent event,
  ) async* {
    if (event is AdminLoginButtonPressed) {
      // Implement your login logic here
      // For simplicity, let's assume a basic check for now
      if (event.username == 'admin' && event.password == 'adminpassword') {
        yield AdminLoginSuccess();
      } else {
        yield AdminLoginFailure(error: 'Invalid username or password');
      }
    }
  }
}
