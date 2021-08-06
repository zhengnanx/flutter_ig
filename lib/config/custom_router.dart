import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ig/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route settings: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case NavScreen.routeName:
        return NavScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Something went wrong')),
      ),
    );
  }

  static Route onGenerateNestedRoute(RouteSettings settings) {
    print('Nested Route: ${settings.name}');
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }
}
