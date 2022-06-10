import 'dart:async';

import 'package:flutter/material.dart';
import 'top_story.dart';

class CommentList extends StatelessWidget {
  final List<Comment> topcomments;
  final Story topstory;

  CommentList({required this.topcomments, required this.topstory});

  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(this.topstory.title),
            backgroundColor: Colors.green[700],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ListView.builder(
                  itemCount: this.topcomments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        alignment: Alignment.center,
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.green[700],
                            borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          "${1 + index}",
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          this.topcomments[index].text,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ));
  }
}
