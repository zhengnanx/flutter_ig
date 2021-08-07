import 'package:flutter/material.dart';
import 'package:flutter_ig/screens/edit_profile/edit_profile_screen.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({
    Key? key,
    required this.isCurrentUser,
    required this.isFollowing,
  }) : super(key: key);

  // case 1: current user--> 'edit profile'
  // case 2: !current user && !following --> 'follow the user'
  // case 3: !current user && following --> 'unfollow the user'
  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
                EditProfileScreen.routeName,
                arguments: EditProfileScreenArgs(context: context)),
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Theme.of(context).primaryColor),
            child: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16.0),
            ))
        : TextButton(
            onPressed: () {},
            style: isFollowing
                ? Colors.grey[300] as ButtonStyle
                : TextButton.styleFrom(
                    primary: isFollowing ? Colors.black : Colors.white,
                    backgroundColor: Theme.of(context).primaryColor),
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: TextStyle(fontSize: 16.0),
            ));
  }
}