import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movinfo/core/base/base_state.dart';
import 'package:movinfo/core/extensions/context_entensions.dart';
import 'package:movinfo/core/init/cache/locale_manager.dart';
import 'package:movinfo/core/init/network/network_manager.dart';
import 'package:movinfo/core/view/movie/model/movie_detail_model.dart';
import 'package:movinfo/core/view/movie/model/movie_model.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({Key? key, required this.data}) : super(key: key);
  final Object? data;
  @override
  _MovieDetailViewState createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends BaseState<MovieDetailView> {
  late Results model;
  StreamController<MovieDetailModel> _streamController = StreamController();
  @override
  void initState() {
    model = widget.data as Results;
    fetchData();
    super.initState();
  }

  void fetchData() async {
    MovieDetailModel items = await NetworkManager.instance
        .getData<MovieDetailModel>('/movie/${model.id}', MovieDetailModel(),
            {'language': getLangKey(LocaleManager.getString('language')!)});
    // ignore: unnecessary_null_comparison
    if (items == null) return;
    _streamController.add(items);
  }

  Widget get noConnection {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Text("Bağlantı Sağlanamadı!"));
  }

  @override
  Widget build(BuildContext context) {
    int totalSize = 0;
    String baseUrl = "https://www.themoviedb.org/t/p/original";
    return Scaffold(
        body: StreamBuilder(
            stream: _streamController.stream,
            builder: (BuildContext context,
                AsyncSnapshot<MovieDetailModel> snapshot) {
              if (snapshot.data == null) return reloadingView;
              MovieDetailModel data = snapshot.data!;
              print("Length:" + data.spokenLanguages!.length.toString());
              final releaseDate = data.releaseDate != null
                  ? '${DateFormat("dd/MM/yyyy").format(DateTime.parse(data.releaseDate!))}'
                  : "";
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return noConnection;
                case ConnectionState.waiting:
                  return reloadingView;
                case ConnectionState.active:
                case ConnectionState.done:
                  return CustomScrollView(slivers: [
                    SliverAppBar(
                      expandedHeight: context.dynamicHeight(0.7),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          data.title!,
                          style: context.textTheme.headline4,
                        ),
                        background: CachedNetworkImage(
                          imageUrl: baseUrl + data.posterPath!,
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      SizedBox(
                        height: context.dynamicHeight(0.01),
                      ),
                      ListTile(
                          title: Text(
                            'Açıklama',
                            style: context.textTheme.headline6,
                          ),
                          subtitle: Text(
                            data.overview!,
                            style: context.textTheme.subtitle1,
                          )),
                      ListTile(
                        title: Text(
                          'Diller',
                          style: context.textTheme.headline6,
                        ),
                        subtitle: ListView.builder(
                            itemCount: data.spokenLanguages!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Text(
                                  data.spokenLanguages![index].name!,
                                  style: context.textTheme.subtitle1,
                                )),
                      ),
                      ListTile(
                          title: Text('Yayınlanma Tarihi',
                              style: context.textTheme.headline6),
                          subtitle: Text(releaseDate,
                              style: context.textTheme.subtitle1)),
                      ListTile(
                          title: Text(
                            "Oy Ortalaması",
                            style: context.textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Column(children: [
                            _rateStar(data.voteAverage!),
                            Text(
                              "${data.voteAverage}/${data.voteCount}",
                              style: context.textTheme.subtitle2,
                            )
                          ])),
                      ListTile(
                          title: Text(
                            'Türleri',
                            style: context.textTheme.headline6,
                          ),
                          subtitle: ListView.builder(
                            itemCount: data.genres!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Text(
                              data.genres![index].name!,
                              style: context.textTheme.subtitle2,
                            ),
                          )),
                      SizedBox(height: context.dynamicHeight(0.01))
                    ]))
                  ]);
              }
            }));
  }

  Widget _rateStar(double voteAverage) {
    int _maxSize = 5;
    int _voteCount = voteAverage.round();
    final stars = List<Widget>.generate(
        _maxSize,
        (index) => index < _voteCount / 2
            ? Icon(
                Icons.star,
                color: Colors.yellow,
              )
            : Icon(Icons.star_border_outlined, color: Colors.yellow));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: stars);
  }

  /* Widget buildDetailScreen(BuildContext context) {
    MovieDetailView data;
    String baseUrl = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == null) return reloadingView;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return noConnection;
          case ConnectionState.waiting:
            return reloadingView;
          case ConnectionState.active:
          case ConnectionState.done:
            return Container(
              decoration: data.backdropPath != null
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(baseUrl + data.backdropPath!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : BoxDecoration(color: Colors.grey.shade200),
              child: SingleChildScrollView(
                child: Padding(
                  padding: context.lowHorizontalPadding,
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: context.symetricPadding(0.002, 0.001),
                          child: CachedNetworkImage(
                              imageUrl: baseUrl + data.posterPath!),
                        ),
                        ListTile(
                          title: Text(data.originalTitle!,
                              textAlign: TextAlign.center,
                              style: context.textTheme.headline5),
                        ),
                        ListTile(
                            title: Text(
                              'Açıklama',
                              style: context.textTheme.subtitle1,
                            ),
                            subtitle: Text(
                              data.overview!,
                              style: context.textTheme.subtitle1,
                            )),
                        ListTile(
                          title: Text('Diller'),
                          subtitle: ListView.builder(
                              itemCount: data.spokenLanguages!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  Text(data.spokenLanguages![index].name!)),
                        ),
                        ListTile(
                            title: Text('Yayınlanma Tarihi'),
                            subtitle: Text(releaseDate)),
                        ListTile(
                            title: Text(
                              "Oy Ortalaması",
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Column(children: [
                              _rateStar(data.voteAverage!),
                              Text(
                                "${data.voteAverage}/${data.voteCount}",
                              )
                            ])),
                        ListTile(
                            title: Text('Türleri'),
                            subtitle: ListView.builder(
                              itemCount: data.genres!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  Text(data.genres![index].name!),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  } */

  Center get reloadingView {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Text("Yükleniyor..."),
      ],
    ));
  }
}
