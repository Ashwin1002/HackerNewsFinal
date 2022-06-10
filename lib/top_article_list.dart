import 'dart:convert';

import 'package:flutter/material.dart';
import 'comment_list.dart';

import 'top_story.dart';
import 'Webservice.dart';

class TopArticleList extends StatefulWidget {
  @override
  State<TopArticleList> createState() => _TopArticleListState();
}

class _TopArticleListState extends State<TopArticleList> {
  List<Story> _stories = <Story>[];

  @override
  void initState() {
    super.initState();
    _populateTopStories();
  }

  void _populateTopStories() async {
    final responses = await Webservice().getTopStories();
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();

    setState(() {
      _stories = stories;
    });
  }

  void _openCommentPage(BuildContext context, int index) async {

    final story = _stories[index];
    final url = _stories[index].url;
    final responses = await Webservice().getCommentsByStory(story);
    final comments = responses.map((response) {
      final json = jsonDecode(response.body);
      return Comment.fromJSON(json);
    }).toList();

    debugPrint("$comments");

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CommentList(topstory: story, topcomments: comments,)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hacker News"),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: ListView.builder(
            itemCount: _stories.length,
            itemBuilder: (_, index) {
              return ListTile(
                onTap: () {
                  _openCommentPage(context, index);
                },
                leading: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: const BorderRadius.all(Radius.circular(5))),
                    alignment: Alignment.center,
                    width: 50,
                    height: 180,
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${index + 1}",
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "${_stories[index].points}p",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(_stories[index].title,
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text('- '),
                              Text(_stories[index].by,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54),
                                textAlign: TextAlign.left,),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.message, color: Colors.red[400], size: 14,),
                              const SizedBox(
                                width: 1.0,
                              ),
                              Text("${_stories[index].descendants}",
                                style: const TextStyle(fontSize: 14,
                                    color: Colors.red),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
