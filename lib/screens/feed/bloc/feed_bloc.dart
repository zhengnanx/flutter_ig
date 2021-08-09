import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ig/blocs/auth/auth_bloc.dart';
import 'package:flutter_ig/models/models.dart';
import 'package:flutter_ig/models/post_model.dart';
import 'package:flutter_ig/repositories/repositories.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;

  FeedBloc({
    required PostRepository postRepository,
    required AuthBloc authBloc,
  })  : _postRepository = postRepository,
        _authBloc = authBloc,
        super(FeedState.initial());

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is FeedFetchPosts) {
      yield* _mapFeedFetchPostsToState();
    } else if (event is FeedPaginatePosts) {
      yield* _mapFeedPaginatePostsToState();
    }
  }

  Stream<FeedState> _mapFeedFetchPostsToState() async* {
    yield state.copyWith(posts: [], status: FeedStatus.loading);
    try {
      final posts =
          await _postRepository.getUserFeed(userId: _authBloc.state.user!.uid);
      yield state.copyWith(
        status: FeedStatus.loaded,
        posts: posts,
      );
    } catch (err) {
      yield state.copyWith(
          status: FeedStatus.error,
          failure: const Failure(message: 'we were unable to load your feed'));
    }
  }

  Stream<FeedState> _mapFeedPaginatePostsToState() async* {}
}
