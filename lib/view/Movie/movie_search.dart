import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:movinfo/core/base/base_state.dart';
import 'package:movinfo/core/constants/navigation_constants.dart';
import 'package:movinfo/core/extensions/context_entensions.dart';
import 'package:movinfo/core/init/cache/locale_manager.dart';
import 'package:movinfo/core/init/navigation/navigate_service.dart';
import 'package:movinfo/core/init/network/network_manager.dart';
import 'package:movinfo/core/view/movie/model/movie_model.dart';
import 'package:movinfo/core/view/search/model/keyword_model.dart' as keywords;

class MovieSearchView extends StatefulWidget {
  const MovieSearchView({Key? key, Object? data}) : super(key: key);

  @override
  _MovieSearchViewState createState() => _MovieSearchViewState();
}

class _MovieSearchViewState extends BaseState<MovieSearchView> {
  late TextEditingController controller;
  late ScrollController scrollController;
  int pageCount = 1;
  List<MovieModel> _items = [];
  StreamController<List<MovieModel>> _streamBuilder = StreamController();
  String suggestion = "";
  int itemCount = 0;
  int tempCount = 0;

  @override
  void initState() {
    scrollController = ScrollController();
    controller = TextEditingController();
    super.initState();
    controller.addListener(() {
      if (controller.text != "") {
        suggestion = controller.text.trim().replaceAll(' ', '%20');
        fetchData();
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        tempCount = itemCount;
        pageCount++;
        fetchData();
        itemCount += tempCount;
      }
    });
  }

  fetchData() async {
    MovieModel response = await NetworkManager.instance
        .getData<MovieModel>('/search/movie', MovieModel(), {
      'query': suggestion,
      'page': pageCount,
      'language': getLangKey(LocaleManager.getString('language')!)
    });
    print(response.results!.isEmpty.toString());
    if (response.results == null) return;
    itemCount = response.results!.length;
    _items.add(response);
    _streamBuilder.add(_items);
  }

  get noConnection {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Text("Bağlantı Sağlanamadı!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: buildSearchBar(),
        ),
        body: StreamBuilder(
          stream: _streamBuilder.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return noConnection;
              case ConnectionState.waiting:
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Yükleniyor..."),
                  ],
                ));
              case ConnectionState.active:
              case ConnectionState.done:
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: itemCount,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          int dataIndex = index ~/ 20;
                          int resultIndex = index % 20;
                          print("DataIndex: " +
                              dataIndex.toString() +
                              "\nResultIndex: " +
                              resultIndex.toString() +
                              "\nIndex:" +
                              index.toString() +
                              "\nItemCount" +
                              itemCount.toString());
                          MovieModel data = snapshot.data[dataIndex];
                          return buildTvViewer(data, resultIndex);
                        },
                      ),
                    ),
                  ],
                );
            }
          },
        ));
  }

  buildTvViewer(MovieModel data, int index) {
    final String baseUrl =
        "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
    final String posterPath = data.results![index].posterPath != null
        ? baseUrl + data.results![index].posterPath!
        : "https://img.utdstc.com/screen/780/8d3/7808d37d64f066960c7570274395f59d9ab4fcbb1f8512878fa5c53346f05e71:200";

    final releaseDate = data.results![index].releaseDate != "" ||
            DateTime.parse(data.results![index].releaseDate!).isUtc
        ? '${DateFormat("dd/MM/yyyy").format(DateTime.parse(data.results![index].releaseDate!))}'
        : "";

    return InkWell(
        onTap: () => NavigationService.instance.navigateToPage(
            NavigationConstants.DETAIL_TV, data.results![index]),
        child: Column(children: [
          SizedBox(
            height: context.dynamicHeight(0.7),
            child: Card(
                color: context.media.platformBrightness == Brightness.dark
                    ? Colors.black87
                    : Colors.grey.shade300,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: CachedNetworkImage(
                          imageUrl: posterPath,
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                      Container(
                        child: ListTile(
                            title: Text(data.results![index].title ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: context.media.platformBrightness ==
                                            Brightness.dark
                                        ? Colors.grey
                                        : Colors.black)),
                            subtitle: ListTile(
                              title: Text(data.results![index].overview ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: context.media.platformBrightness ==
                                              Brightness.dark
                                          ? Colors.grey
                                          : Colors.black)),
                              subtitle: Text(
                                releaseDate,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: context.media.platformBrightness ==
                                            Brightness.dark
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                            )),
                      ),
                    ])),
          )
        ]));
  }

  Widget buildSearchBar() {
    return TypeAheadField<keywords.Results>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear), onPressed: () => controller.clear()),
          hintText: 'Film Giriniz.',
          hintStyle: TextStyle(
              fontFamily: 'Robogo', color: Color.fromRGBO(197, 197, 197, 1)),
        ),
      ),
      suggestionsCallback: (String pattern) async {
        if (pattern == '') {
          return const Iterable<keywords.Results>.empty();
        }
        String searchValue = pattern.trim().replaceAll(' ', '%20');
        this.suggestion = searchValue;
        _items.clear();
        itemCount = 0;
        fetchData();
        keywords.KeywordModel data = await NetworkManager.instance
            .getData<keywords.KeywordModel>('/search/keyword',
                keywords.KeywordModel(), {'query': searchValue, 'page': 1});
        return data.results!;
      },
      onSuggestionSelected: (keywords.Results suggestion) {
        this.suggestion = suggestion.name!.trim().replaceAll(' ', '%20');
        _items.clear();
        itemCount = 0;
        fetchData();
      },
      itemBuilder: (BuildContext context, keywords.Results itemData) {
        return Container(child: ListTile(title: Text(itemData.name!)));
      },
    );
  }
}
