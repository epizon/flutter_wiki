

import 'package:flutter/material.dart';
import 'package:flutter_wiki/services/api.dart';
import 'package:flutter_wiki/models/search_response.dart';


class SearchViewModel extends ChangeNotifier {

  bool busy = false;
  setBusy(bool busy){
    this.busy = busy;
    notifyListeners();
  }
  List<SearchResult> results = List<SearchResult>();

  Future<void> fetchResults(String key) async {
    setBusy(true);
    results =  await Api().fetchResults(key);
    setBusy(false);
  }

}