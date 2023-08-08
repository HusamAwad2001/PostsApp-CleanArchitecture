part of 'crud_posts_bloc.dart';

abstract class CrudPostsEvent extends Equatable {
  const CrudPostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends CrudPostsEvent {
  final Post post;

  const AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends CrudPostsEvent {
  final Post post;

  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends CrudPostsEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
