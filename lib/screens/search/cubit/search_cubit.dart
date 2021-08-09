import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ig/models/models.dart';
import 'package:flutter_ig/repositories/repositories.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository _userRepository;
  SearchCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SearchState.initial());
  void searchUsers(String query) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final users = await _userRepository.searchUsers(query: query);
      emit(state.copyWith(users: users, status: SearchStatus.loaded));
    } catch (err) {
      state.copyWith(
          status: SearchStatus.error,
          failure: const Failure(
              message: 'Something went wrong, can\'t find the user'));
    }
  }

  void clearSearch() {
    emit(state.copyWith(status: SearchStatus.initial, users: []));
  }
}
