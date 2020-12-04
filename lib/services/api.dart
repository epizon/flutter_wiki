import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_wiki/models/search_response.dart';
import 'package:flutter_wiki/models/details_response.dart';
import 'package:dio/dio.dart';

class Api {
  DioCacheManager _dioCacheManager;

  Future<List<SearchResult>> fetchResults(String keyword) async {
    try {
      keyword = keyword.replaceAll(" ", "+");
      final url =
          "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=100&pilimit=10&wbptterms=description&gpssearch=$keyword&gpslimit=10";
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions =
          buildCacheOptions(Duration(days: 7), forceRefresh: true);
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.connectTimeout = 5000;
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        SearchResponse searchResponse =
            SearchResponse.fromJson(response.data);
        return searchResponse.query.pages;
      }
    } catch (_) {
      print('fetchResultsError${_.toString()}');
    }
    return List();
  }

  Future<DetailsResult> fetchDetails(String pageId) async {
    try {
      final url =
          "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&pageids=$pageId";
      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions =
      buildCacheOptions(Duration(days: 7), forceRefresh: true);
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager.interceptor);
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.connectTimeout = 5000;
      Response response = await _dio.get(url, options: _cacheOptions);
      if (response.statusCode == 200) {
        DetailsResponse detailsResponse =
        DetailsResponse.fromJson(response.data);
        return detailsResponse.query.detailsResult;
      }
    } catch (_) {
      print('fetchDetails${_.toString()}');
    }
    return null;
  }
}
