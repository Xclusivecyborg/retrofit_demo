import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_demo/post_model.dart';
import 'package:retrofit_demo/rest_client.dart';
import 'package:retrofit_demo/view.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({
    super.key,
    required this.postId,
  });
  final int postId;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Post? post;
  List<Comment> _comments = [];
  Status _status = Status.loading;
  Status _commentStatus = Status.loading;
  String _errorMessage = '';

  final RestClient _restClient = RestClient(Dio());

  void getSinglePost() async {
    try {
      final response = await _restClient.getSinglePost(widget.postId);
      setState(() {
        _status = Status.success;
        post = response;
      });
    } on DioException catch (e) {
      setState(() {
        _status = Status.error;
        _errorMessage = e.message ?? "An error occurred";
      });
    } catch (e) {
      setState(() {
        _status = Status.error;
        _errorMessage = e.toString();
      });
    }
  }

  void getComments() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final response = await _restClient.getComments({
        'postId': '${widget.postId}',
      });
      setState(() {
        _commentStatus = Status.success;
        _comments = response;
      });
    } on DioException catch (e) {
      setState(() {
        _commentStatus = Status.error;
        _errorMessage = e.message ?? "An error occurred";
      });
    } catch (e) {
      setState(() {
        _commentStatus = Status.error;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSinglePost();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Column(
        children: [
          switch (_status) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => Center(
                child: Text(
                  _errorMessage,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            _ => Center(
                child: PostCard(post: post!),
              ),
          },
          switch (_commentStatus) {
            Status.loading => const Center(child: CircularProgressIndicator()),
            Status.error => Center(
                child: Text(
                  _errorMessage,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            _ when _comments.isEmpty => const Center(
                child: Text(
                  'No Comments found',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            _ => Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    final comment = _comments[index];
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            comment.body,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            comment.email,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: _comments.length,
                ),
              ),
          },
        ],
      ),
    );
  }
}
