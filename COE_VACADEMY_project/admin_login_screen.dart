import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_bloc.dart';

class AdminLoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AdminBloc adminBloc = BlocProvider.of<AdminBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Admin Login')),
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminLoginSuccess) {
            // Navigate to admin dashboard or next screen
            Navigator.pushReplacementNamed(context, '/admin_dashboard');
          } else if (state is AdminLoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      adminBloc.add(
                        AdminLoginButtonPressed(
                          username: _usernameController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
