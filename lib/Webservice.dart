import 'dart:convert';

import 'top_story.dart';
import 'urlHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Webservice {
  Future<Response> _getStory(int storyId) {
    return http.get(Uri.parse(UrlHelper.urlForStory(storyId)));
  }

  Future<List<Response>> getCommentsByStory(Story story) async {
    return Future.wait(story.commentIds.take(story.commentIds.length).map((commentId) {
      return http.get(Uri.parse(UrlHelper.urlForCommentId(commentId)));
    }));
  }

  Future<List<Response>> getTopStories() async {
    final response = await http.get(Uri.parse(UrlHelper.urlForTopStory()));
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.take(25).map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Unable to fetch data!");
    }
  }
}