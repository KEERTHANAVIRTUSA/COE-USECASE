import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacademy/admin_dashboard.dart';

import 'admin_bloc.dart';
import 'admin_login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V-Academy',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => AdminBloc(),
        child: AdminLoginScreen(),
      ),
      routes: {
        '/admin_dashboard': (context) => AdminDashboard(), // Create AdminDashboard widget
      },
    );
  }
}
