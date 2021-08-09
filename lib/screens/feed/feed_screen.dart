import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ig/widgets/widgets.dart';

import 'bloc/feed_bloc.dart';

class FeedScreen extends StatefulWidget {
  static const String routeName = '/feed';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state.status == FeedStatus.error) {
          showDialog(
              context: context,
              builder: (context) =>
                  ErrorDialog(content: state.failure.message));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Scaffold(
            appBar: AppBar(
              title: const Text('Instagram'),
              actions: [
                if (state.posts.isEmpty && state.status == FeedStatus.loaded)
                  IconButton(
                      onPressed: () =>
                          context.read<FeedBloc>().add(FeedFetchPosts()),
                      icon: const Icon(Icons.refresh))
              ],
            ),
            body: _buildBody(state),
          ),
        );
      },
    );
  }

  Widget _buildBody(FeedState state) {
    switch (state.status) {
      case FeedStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      default:
        return RefreshIndicator(
          onRefresh: () async {
            context.read<FeedBloc>().add(FeedFetchPosts());
          },
          child: ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (BuildContext context, int index) {
                final post = state.posts[index];
                return PostView(post: post, isLiked: false);
              }),
        );
    }
  }
}
