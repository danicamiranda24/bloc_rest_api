part of 'post_bloc.dart';

@immutable
sealed class PostState {}
abstract class PostActionState extends PostState {}

final class PostInitial extends PostState {}

class PostFetchingSuccessfulState extends PostState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccessfulState({required this.posts});
  
}

class PostFetchingLoadingState extends PostState {

}

class PostFetchingErrorState extends PostState {

}

class PostAddSuccessState extends PostActionState {

}

class PostAddErrorState extends PostActionState {

}