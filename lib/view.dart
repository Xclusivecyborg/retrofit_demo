import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_demo/post_detail.dart';
import 'package:retrofit_demo/post_model.dart';
import 'package:retrofit_demo/rest_client.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  List<Post> _posts = [];
  Status _status = Status.loading;
  String _errorMessage = '';

  final RestClient _restClient = RestClient(Dio());

  void getPosts() async {
    try {
      final response = await _restClient.getPosts();
      log('$response');
      setState(() {
        _status = Status.success;
        _posts = response;
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

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrofit App'),
      ),
      body: switch (_status) {
        Status.loading => const Center(child: CircularProgressIndicator()),
        Status.error => Center(
            child: Text(
              _errorMessage,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        _ when _posts.isEmpty => const Center(
            child: Text(
              'No posts found',
              style: TextStyle(fontSize: 24),
            ),
          ),
        _ => ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              final post = _posts[index];
              return PostCard(
                post: post,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetail(postId: post.id),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: _posts.length,
          ),
      },
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    this.onTap,
  });

  final Post post;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.id.toString(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              post.ourTitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              post.body,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Status {
  loading,
  success,
  error,
}
