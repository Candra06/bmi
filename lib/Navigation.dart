import 'package:bmi_score/HomeScreen.dart';
import 'package:bmi_score/LoginInputSreen.dart';
import 'package:bmi_score/RegisterInputScreen.dart';
import 'package:flutter/material.dart';

class Navigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // jika ingin mengirim argument
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const RegisterInputScreen());
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginInputScreen(
            userData: settings.arguments as Map,
          ),
        );
      case '/home':
        return MaterialPageRoute(
            builder: (_) => HomeInputScreen(
                  userData: settings.arguments as Map,
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Not Found"),
        ),
        body: const Center(
          child: Text('Page Not Found'),
        ),
      );
    });
  }
}
