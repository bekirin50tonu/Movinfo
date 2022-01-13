import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movinfo/core/base/base_state.dart';
import 'package:movinfo/core/constants/app_constants.dart';
import 'package:movinfo/core/constants/navigation_constants.dart';
import 'package:movinfo/core/extensions/context_entensions.dart';
import 'package:movinfo/core/init/cache/locale_manager.dart';
import 'package:movinfo/core/init/navigation/navigate_service.dart';
import 'package:movinfo/core/init/network/network_manager.dart';
import 'package:movinfo/core/view/movie/model/movie_model.dart';

class MovieList extends StatefulWidget {
  final String path;
  const MovieList({Key? key, required this.path}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends BaseState<MovieList> {
  // ignore: close_sinks
  StreamController<List<MovieModel>> movieController = StreamController();
  List<MovieModel> _items = [];
  int _itemCount = 0;

  //page scroll variables
  int _duration = 1;
  Cubic _curves = Curves.fastOutSlowIn;

  late ScrollController scrollController;
  int currentPage = 1;

  bool showFloatingActionButton = false;
  bool autoScroll = true;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    fetchData();
    var previousVariable = -1;
    var nextVariable = 1;
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        /* print("Variable: " +
          variable.toString() +
          "\nScroll Position: " +
          scrollController.position.pixels.toString()); */
        if (autoScroll == true) {
          var variable =
              (scrollController.position.pixels / context.dynamicHeight(0.7))
                  .round();
          if (variable == nextVariable) {
            scrollController.animateTo(context.dynamicHeight(0.7) * variable,
                duration: Duration(seconds: _duration), curve: _curves);
            nextVariable++;
            previousVariable++;
          } else if (variable == previousVariable) {
            scrollController.animateTo(context.dynamicHeight(0.7) * variable,
                duration: Duration(seconds: _duration), curve: _curves);
            nextVariable--;
            previousVariable--;
          }
          if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels) {
            currentPage++;
            fetchData();
          }
        }

        if (scrollController.position.pixels > context.dynamicHeight(0.7)) {
          showFloatingActionButton = true;
        } else {
          showFloatingActionButton = false;
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void fetchData() async {
    print("DİL İŞTE BU : " + getLangKey(LocaleManager.getString('language')!)!);
    MovieModel items = await NetworkManager.instance
        .getData<MovieModel>(widget.path, MovieModel(), {
      'language': getLangKey(LocaleManager.getString('language')!),
      'page': this.currentPage,
      'region': getCountryKey(LocaleManager.getString('country')!)
    });
    if (items == null || items.results == null) return;
    _itemCount += items.results!.length;
    _items.add(items);
    movieController.add(_items);
  }

  Widget get noConnection {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Text("Bağlantı Sağlanamadı!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: showFloatingActionButton
            ? FloatingActionButton(
                child: Icon(Icons.arrow_upward_outlined),
                onPressed: () async {
                  autoScroll = false;
                  await scrollController.animateTo(0,
                      duration: Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn);
                  autoScroll = true;
                },
              )
            : null,
        body: StreamBuilder(
          stream: movieController.stream,
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
                        itemCount: _itemCount,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          int dataIndex = index ~/ 20;
                          int resultIndex = index % 20;
                          /*  print("DataIndex: " +
                          dataIndex.toString() +
                          "\nResultIndex: " +
                          resultIndex.toString() +
                          "\nIndex:" +
                          index.toString()); */
                          var data = snapshot.data[dataIndex];
                          return buildMovieViewer(data, resultIndex);
                        },
                      ),
                    ),
                  ],
                );
            }
          },
        ));
  }

  buildMovieViewer(MovieModel data, int index) {
    final String baseUrl =
        "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
    final posterPath = data.results![index].posterPath != null
        ? baseUrl + data.results![index].posterPath!
        : "https://img.utdstc.com/screen/780/8d3/7808d37d64f066960c7570274395f59d9ab4fcbb1f8512878fa5c53346f05e71:200";
    final releaseDate = data.results![index].releaseDate != "" ||
            DateTime.parse(data.results![index].releaseDate!).isUtc
        ? '${DateFormat("dd/MM/yyyy").format(DateTime.parse(data.results![index].releaseDate!))}'
        : "";
    return InkWell(
        onTap: () => NavigationService.instance.navigateToPage(
            NavigationConstants.DETAIL_MOVIE, data.results![index]),
        child: SizedBox(
          height: context.dynamicHeight(0.7),
          child: Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Flexible(
                  child: CachedNetworkImage(
                    imageUrl: posterPath,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Container(
                  child: ListTile(
                      title: Text(data.results![index].title ?? "",
                          textAlign: TextAlign.center,
                          style: context.textTheme.headline5),
                      subtitle: ListTile(
                        title: Text(data.results![index].overview ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.headline6),
                        subtitle: Text(
                          "Yayınlanma Tarihi: $releaseDate",
                          textAlign: TextAlign.center,
                          style: context.textTheme.subtitle2,
                        ),
                      )),
                ),
              ])),
        ));
  }
}
