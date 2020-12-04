import 'package:flutter/material.dart';
import 'package:flutter_wiki/services/api.dart';
import 'package:flutter_wiki/models/search_response.dart';
import 'package:flutter_wiki/models/details_response.dart';


class DetailsViewModel extends ChangeNotifier {

  bool busy = false;
  setBusy(bool busy){
    this.busy = busy;
    notifyListeners();
  }
  SearchResult searchResult;
  DetailsResult detailsResult;

  Future<void> fetchDetails() async {
    if(searchResult == null){
      return;
    }
    setBusy(true);
    detailsResult =  await Api().fetchDetails(searchResult.pageid.toString());
    setBusy(false);
  }

}