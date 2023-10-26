import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: 'userId', defaultValue: 0)
  final num userid; //userId
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;
  @JsonKey(name: 'title', defaultValue: '')
  final String ourTitle;
  final String body;

  Post({
    required this.userid,
    required this.id,
    required this.ourTitle,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() {
    return 'Post{userId: $userid, id:$id, title: $ourTitle, body: $body}';
  }
}

// {
// "postId": 1,
// "id": 2,
// "name": "quo vero reiciendis velit similique earum",
// "email": "Jayne_Kuhic@sydney.com",
// "body": "est natus enim nihil est dolore omnis voluptatem numquam et omnis occaecati quod ullam at voluptatem error expedita pariatur nihil sint nostrum voluptatem reiciendis et"
// },

@JsonSerializable(createToJson: false)
class Comment {
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;
  final int postId;
  @JsonKey(name: 'title', defaultValue: '')
  final String name;
  final String body;
  final String email;

  Comment({
    required this.postId,
    required this.id,
    required this.email,
    required this.body,
    required this.name,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  @override
  String toString() {
    return 'Comment{postId: $postId, id:$id, name: $name, body: $body, email: $email}';
  }
}
