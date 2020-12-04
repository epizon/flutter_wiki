import 'package:flutter/material.dart';
import 'package:flutter_wiki/view_models/search_view_model.dart';
import 'package:flutter_wiki/view_models/details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wiki/pages/details_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Wiki Search",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black45),
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Provider.of<SearchViewModel>(context).fetchResults(value);
                      _controller.clear();
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
              Expanded(
                child:
                    Consumer<SearchViewModel>(builder: (context, viewModel, _) {
                  return viewModel.busy ? Center(child: CircularProgressIndicator()) : ListView.builder(
                    itemCount: viewModel.results.length,
                    itemBuilder: (context, index) {
                      final searchResult = viewModel.results[index];
                      return ListTile(
                        onTap: (){
                          Provider.of<DetailsViewModel>(context).searchResult = searchResult;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage()));
                        },
                        contentPadding: EdgeInsets.all(10),
                        leading: searchResult.thumbnail != null
                            ? Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          searchResult.thumbnail.source),
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                width: 50,
                                height: 50,
                              )
                            : Container(child: Icon(Icons.image, size: 50, color: Colors.grey.withOpacity(0.5),)),
                        title: Text(searchResult.title),
                      );
                    },
                  );
                }),
              )
            ])));
  }
}
