import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/add_post_usecase.dart';
import '../../../domain/use_cases/delete_post_usecase.dart';
import '../../../domain/use_cases/update_post_usecase.dart';

part 'crud_posts_event.dart';
part 'crud_posts_state.dart';

class CrudPostsBloc extends Bloc<CrudPostsEvent, CrudPostsState> {
  final AddPostUseCase addPosts;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;

  CrudPostsBloc({
    required this.addPosts,
    required this.updatePost,
    required this.deletePost,
  }) : super(CrudPostsInitial()) {
    on<CrudPostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingCrudPostsState());
        final failureOrDoneMessage = await addPosts(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingCrudPostsState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingCrudPostsState());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  CrudPostsState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorCrudPostsState(message: _getErrorMessage(failure)),
      (_) => MessageCrudPostsState(message: message),
    );
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, please try again later.';
    }
  }
}
