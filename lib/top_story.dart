class Comment {
  String text = "";
  final int commentId;

  Comment({ required this.commentId, required this.text});

  factory Comment.fromJSON(Map<String, dynamic> json) {
    return Comment(commentId: json["id"], text: json["text"] == null ? "null": json["text"]);
  }
}


class Story {

  final String title;
  final String url;
  final String by;
  final int points;
  final int time;
  final int descendants;
  List<int> commentIds = <int>[];

  Story({
    required this.title,
    required this.url,
    required this.by,
    required this.points,
    required this.time,
    required this.descendants,
    required this.commentIds
  });

  factory Story.fromJSON(Map<String, dynamic> json) {
    return Story(
        title: json["title"],
        url: json["url"] == null ? "https://github.com" : json["url"],
        by: json["by"],
        points: json["score"],
        time: json["time"],
        descendants: json["descendants"] == null ? 0: json["descendants"],
        commentIds:
        json["kids"] == null ? <int>[] : json["kids"].cast<int>());
  }

}