part of 'crud_posts_bloc.dart';

abstract class CrudPostsState extends Equatable {
  const CrudPostsState();
}

class CrudPostsInitial extends CrudPostsState {
  @override
  List<Object> get props => [];
}

class LoadingCrudPostsState extends CrudPostsState {
  @override
  List<Object> get props => [];
}

class ErrorCrudPostsState extends CrudPostsState {
  final String message;

  const ErrorCrudPostsState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageCrudPostsState extends CrudPostsState {
  final String message;

  const MessageCrudPostsState({required this.message});

  @override
  List<Object> get props => [message];
}
