import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_rest_api/features/posts/models/post_data_ui_model.dart';
import 'package:bloc_rest_api/features/posts/repos/posts_repositories.dart';
import 'package:dio/dio.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostFetchingLoadingState());

    List<PostDataUiModel> posts = await PostRepo.fetchPosts();
    try {
      emit(PostFetchingSuccessfulState(posts: posts));
    } catch (e) {
      emit(PostFetchingErrorState());
    }
  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostState> emit) async {
  bool success = await PostRepo.addPost();
  if (success) {
    print(success);
    emit(PostAddSuccessState());
  } else {
    emit(PostAddErrorState());
  }
  }
}
