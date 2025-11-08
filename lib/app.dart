import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_employee_screen.dart';
import 'screens/register_company_screen.dart';

class HnhApp extends StatelessWidget {
  const HnhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HNH Commute Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Consumer<AppState>(
        builder: (context, state, _) {
          if (state.currentMember == null) {
            return const LoginScreen();
          }
          return const DashboardScreen();
        },
      ),
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterCompanyScreen.routeName: (_) => const RegisterCompanyScreen(),
        RegisterEmployeeScreen.routeName: (_) => const RegisterEmployeeScreen(),
        DashboardScreen.routeName: (_) => const DashboardScreen(),
      },
    );
  }
}
