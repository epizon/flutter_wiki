class SearchResponse {
  bool batchcomplete;
  Query query;

  SearchResponse({this.batchcomplete, this.query});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    batchcomplete = json['batchcomplete'];
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }
}

class Query {
  List<Redirects> redirects;
  List<SearchResult> pages;

  Query({this.redirects, this.pages});

  Query.fromJson(Map<String, dynamic> json) {
    if (json['redirects'] != null) {
      redirects = new List<Redirects>();
      json['redirects'].forEach((v) {
        redirects.add(new Redirects.fromJson(v));
      });
    }
    if (json['pages'] != null) {
      pages = new List<SearchResult>();
      json['pages'].forEach((v) {
        pages.add(new SearchResult.fromJson(v));
      });
    }
  }
}

class Redirects {
  int index;
  String from;
  String to;

  Redirects({this.index, this.from, this.to});

  Redirects.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    from = json['from'];
    to = json['to'];
  }
}

class SearchResult {
  int pageid;
  String title;
  int index;
  Thumbnail thumbnail;
  Terms terms;

  SearchResult(
      {this.pageid,
      this.title,
      this.index,
      this.thumbnail,
      this.terms});

  SearchResult.fromJson(Map<String, dynamic> json) {
    pageid = json['pageid'];
    title = json['title'];
    index = json['index'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    terms = json['terms'] != null ? new Terms.fromJson(json['terms']) : null;
  }
}

class Thumbnail {
  String source;
  int width;
  int height;

  Thumbnail({this.source, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    width = json['width'];
    height = json['height'];
  }
}

class Terms {
  List<String> description;

  Terms({this.description});

  Terms.fromJson(Map<String, dynamic> json) {
    description = json['description'].cast<String>();
  }
}
