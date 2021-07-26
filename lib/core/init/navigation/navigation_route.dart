import 'package:flutter/material.dart';
import 'package:movinfo/core/constants/navigation_constants.dart';
import 'package:movinfo/view/Movie/movie_detail.dart';
import 'package:movinfo/view/Movie/movie_list.dart';
import 'package:movinfo/view/Movie/movie_search.dart';
import 'package:movinfo/view/NotFound/page_not_found_view.dart';
import 'package:movinfo/view/TV/tv_detail.dart';
import 'package:movinfo/view/TV/tv_search.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;
  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.DETAIL_MOVIE:
        return MaterialPageRoute(
            builder: (context) => MovieDetailView(data: args.arguments));
      case NavigationConstants.DETAIL_TV:
        return MaterialPageRoute(
            builder: (context) => TVDetailView(data: args.arguments));
      case NavigationConstants.MOVIE_SEARCH:
        return MaterialPageRoute(builder: (context) => MovieSearchView());
      case NavigationConstants.TV_SEARCH:
        return MaterialPageRoute(builder: (context) => TVSearchView());
      default:
        return MaterialPageRoute(
          builder: (context) => PageNotFoundView(),
        );
    }
  }
}
