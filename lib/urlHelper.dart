
class UrlHelper {

  static String urlForStory(int storyId) {
    return "https://hacker-news.firebaseio.com/v0/item/${storyId}.json?print=pretty";
  }

  static String urlForTopStory () {
    return "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty";
  }

  static String urlForCommentId(int commentId) {
    return "https://hacker-news.firebaseio.com/v0/item/${commentId}.json?print=pretty";
  }

}