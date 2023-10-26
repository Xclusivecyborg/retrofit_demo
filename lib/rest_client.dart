import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit_demo/post_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/posts')
  Future<List<Post>> getPosts();
  @GET('/posts/{postId}')
  Future<Post> getSinglePost(@Path() int postId);

  @GET('/comments')
  Future<List<Comment>> getComments(@Queries() Map<String, dynamic> queries);

  @POST('/profile_picture')
  @MultiPart()
  Future<void> uploadPicture({
    @Part() required String username,
    @Part() required String password,
    @Part(name: 'first_name') required String firstName, //first_name
    @Part(name: 'profile_picture') required File profilePicture,
  });
}

//Image
//USername
//Password
//First name

//POST ID
//Path (Url)
//Body,
//QueryParameter

///https:google.com/xclusivecyborg/1?name=cyborg&age=12&height=5.6
/////1 Path parameter 