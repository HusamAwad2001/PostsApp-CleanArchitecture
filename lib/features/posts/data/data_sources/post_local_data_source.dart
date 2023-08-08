import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_architecture/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

const cachedPosts = 'CACHED_POSTS';

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> posts) async {
    final postModelToJson = posts.map((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString(cachedPosts, jsonEncode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(cachedPosts);
    if (jsonString != null) {
      final List jsonList = jsonDecode(jsonString);
      final List<PostModel> posts = jsonList.map((json) => PostModel.fromJson(json)).toList();
      return Future.value(posts);
    } else {
      throw EmptyCacheException();
    }
  }
}
