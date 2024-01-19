import 'dart:developer';

import 'package:bloc_rest_api/features/posts/models/post_data_ui_model.dart';
import 'package:dio/dio.dart';

class PostRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    final Dio _dio = Dio();
    List<PostDataUiModel> posts = [];
    try {
      Response _response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');

      List<dynamic> result = _response.data;

      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post = PostDataUiModel.fromMap(result[i]);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    final Dio _dio = Dio();
    List<PostDataUiModel> posts = [];
    try {
      Map<String, dynamic> postData = {
        "title": "Hello",
        "body": "World",
        "userId": 34,
      };
      Response _response = await _dio
          .post('https://jsonplaceholder.typicode.com/posts', data: postData);

      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
