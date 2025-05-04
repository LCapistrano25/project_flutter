import 'package:facebook/requests/post_service.dart';
import 'package:flutter/material.dart';
import 'package:facebook/models/post.dart';
import 'package:facebook/requests/service.dart';

void main() {
  runApp(MaterialApp(home: MainScreen()));
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int status = 0; // 0 = loading, 200 = success, 404 = empty, 500+ = error
  List<Post> posts = [];

  final messages = {
    'error': ['Error', 'Error description'],
    'loading': ['Loading...', 'Loading description'],
    'success': ['Success', 'Success description'],
    'empty': ['Empty', 'Empty description'],
  };

  @override
  void initState() {
    super.initState();
    _searchData();
  }

  void _searchData() async {
    setState(() => status = 0); // loading

    var response = await PostService.fetchPosts();
    List<Post> fetchedPosts = response[0];
    int statusCode = response[1];

    setState(() {
      posts = fetchedPosts;
      status = statusCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 0:
        return _loadingScreen();
      case 200:
        return _successScreen();
      case 404:
        return _emptyScreen();
      default:
        return _errorScreen();
    }
  }

  Widget _successScreen() {
    return Scaffold(
      appBar: AppBar(title: Text(messages['success']![0])),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _searchData,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _errorScreen() {
    return Scaffold(
      appBar: AppBar(title: Text(messages['error']![0])),
      body: Center(child: Text(messages['error']![1])),
      floatingActionButton: FloatingActionButton(
        onPressed: _searchData,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _emptyScreen() {
    return Scaffold(
      appBar: AppBar(title: Text(messages['empty']![0])),
      body: Center(child: Text(messages['empty']![1])),
    );
  }

  Widget _loadingScreen() {
    return Scaffold(
      appBar: AppBar(title: Text(messages['loading']![0])),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
