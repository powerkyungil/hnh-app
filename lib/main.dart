import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/ceo/ceo_main_screen.dart';
import 'screens/employee/employee_main_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commute App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F4F6),
        primaryColor: const Color(0xFF34C759),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF34C759),
          primary: const Color(0xFF34C759),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F4F6),
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Color(0xFF191F28)),
          titleTextStyle: TextStyle(
            color: Color(0xFF191F28),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF191F28),
          unselectedItemColor: Color(0xFF8B95A1),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/ceo_main': (context) => const CeoMainScreen(),
        '/employee_main': (context) => const EmployeeMainScreen(),
      },
    );
  }
}
