import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ig/blocs/auth/auth_bloc.dart';
import 'package:flutter_ig/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter_ig/widgets/widgets.dart';
import 'package:flutter_ig/screens/profile/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

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
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(
              context: context,
              builder: (context) =>
                  ErrorDialog(content: state.failure.message));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.user.username),
            actions: [
              if (state.isCurrentUser)
                IconButton(
                    onPressed: () =>
                        context.read<AuthBloc>().add(AuthLogoutRequested()),
                    icon: const Icon(Icons.exit_to_app))
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0.0),
                    child: Row(
                      children: [
                        UserProfileImage(
                            radius: 40.0,
                            profileImageUrl: state.user.profileImageUrl),
                        ProfileStats(
                            isCurrentUser: state.isCurrentUser,
                            isFollowing: state.isFollowing,
                            posts: 0,
                            followers: state.user.followers,
                            following: state.user.following)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: ProfileInfo(
                        username: state.user.username, bio: state.user.bio),
                  )
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
