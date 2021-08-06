import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = '/notifications';

  // static Route route() {
  //   return PageRouteBuilder(
  //       settings: const RouteSettings(name: routeName),
  //       transitionDuration: const Duration(seconds: 0),
  //       pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
  //             create: (_) =>
  //                 LoginCubit(authRepository: context.read<AuthRepository>()),
  //             child: LoginScreen(),
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Notifications Screen'),
      ),
    );
  }
}
