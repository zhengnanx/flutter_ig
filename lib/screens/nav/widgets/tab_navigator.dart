import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ig/blocs/auth/auth_bloc.dart';
import 'package:flutter_ig/config/custom_router.dart';
import 'package:flutter_ig/enums/bottom_nav_item.dart';
import 'package:flutter_ig/repositories/repositories.dart';
import 'package:flutter_ig/screens/create_post/cubit/create_post_cubit.dart';
import 'package:flutter_ig/screens/feed/bloc/feed_bloc.dart';
import 'package:flutter_ig/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter_ig/screens/screens.dart';
import 'package:flutter_ig/screens/search/cubit/search_cubit.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({Key? key, required this.navigatorKey, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // construct a state for each nav screen
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders[initialRoute]!(context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        return BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(
            postRepository: context.read<PostRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
          child: FeedScreen(),
        );
      case BottomNavItem.search:
        return BlocProvider<SearchCubit>(
          create: (context) =>
              SearchCubit(userRepository: context.read<UserRepository>()),
          child: SearchScreen(),
        );
      case BottomNavItem.create:
        return BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(
              postRepository: context.read<PostRepository>(),
              storageRepository: context.read<StorageRepository>(),
              authBloc: context.read<AuthBloc>()),
          child: CreatePostScreen(),
        );
      case BottomNavItem.notifications:
        return NotificationsScreen();
      case BottomNavItem.profile:
        return BlocProvider(
          create: (_) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
              postRepository: context.read<PostRepository>(),
              authBloc: context.read<AuthBloc>())
            ..add(ProfileLoadUser(
                userId: context.read<AuthBloc>().state.user!.uid)),
          child: ProfileScreen(),
        );
      default:
        return Scaffold();
    }
  }
}
