import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/search_page.dart';
import 'view_models/search_view_model.dart';
import 'view_models/details_view_model.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SearchViewModel>(
              create: (context) => SearchViewModel()),
          ChangeNotifierProvider<DetailsViewModel>(
              create: (context) => DetailsViewModel()),
        ],
        child: MaterialApp(
          title: "Wiki Search",
          theme: ThemeData(primarySwatch: Colors.yellow),
          debugShowCheckedModeBanner: false,
          home: SearchPage(),
        ));
  }
}
