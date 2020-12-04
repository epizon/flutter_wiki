
class DetailsResponse {
  String batchcomplete;
  Query query;

  DetailsResponse({this.batchcomplete, this.query});

  DetailsResponse.fromJson(Map<String, dynamic> json) {
    batchcomplete = json['batchcomplete'];
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }
}

class Query {
  DetailsResult detailsResult;
  Query({this.detailsResult});

  Query.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> pages = json['pages'] != null ? json['pages'] : null;
    detailsResult = DetailsResult.fromJson(pages.values.first);
  }
}

class DetailsResult {
  int pageid;
  int ns;
  String title;
  String extract;

  DetailsResult({this.pageid, this.ns, this.title, this.extract});

  DetailsResult.fromJson(Map<String, dynamic> json) {
    pageid = json['pageid'];
    ns = json['ns'];
    title = json['title'];
    extract = json['extract'];
  }
}