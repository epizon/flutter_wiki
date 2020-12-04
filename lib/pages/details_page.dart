import 'package:flutter/material.dart';
import 'package:flutter_wiki/view_models/details_view_model.dart';
import 'package:flutter_wiki/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DetailsViewModel>(context, listen: false).fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      ),
      body: Consumer<DetailsViewModel>(builder: (context, viewModel, _) {
        return viewModel.busy ? Center(child: CircularProgressIndicator()) : Container(
            padding: EdgeInsets.all(30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    viewModel.searchResult.thumbnail != null
                        ? Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      viewModel.searchResult.thumbnail.source),
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            width: 150,
                            height: 150,
                          )
                        : Container(child: Icon(Icons.image, size: 150, color: Colors.grey.withOpacity(0.5),)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        viewModel.detailsResult == null
                            ? ''
                            : viewModel.detailsResult.title,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        viewModel.detailsResult == null
                            ? ''
                            : viewModel.detailsResult.extract,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black)),
                  ]),
            ));
      }),
    );
  }
}
