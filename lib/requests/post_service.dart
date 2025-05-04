
import 'package:facebook/models/post.dart';
import 'package:facebook/requests/service.dart';

class PostService {
  static Future<List> fetchPosts() async {
    await Future.delayed(Duration(seconds: 5)); // Simulate network delay
    const url = "https://jsonplaceholder.typicode.com/posts";
    final response = await ApiService.request(
      url: url,
      verb: HttpVerb.get,
      fromJson: (json) =>
          (json as List).map((e) => Post.fromJson(e)).toList(),
    );

    return [response.data ?? [], response.statusCode];
  }
}
