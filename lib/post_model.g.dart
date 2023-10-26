// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      userid: json['userId'] as num? ?? 0,
      id: json['id'] as int? ?? 0,
      ourTitle: json['title'] as String? ?? '',
      body: json['body'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'userId': instance.userid,
      'id': instance.id,
      'title': instance.ourTitle,
      'body': instance.body,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      postId: json['postId'] as int,
      id: json['id'] as int? ?? 0,
      email: json['email'] as String,
      body: json['body'] as String,
      name: json['title'] as String? ?? '',
    );
