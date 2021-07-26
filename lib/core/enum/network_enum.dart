enum MovieRoute { UPCOMING, NOW_PLAYING, POPULAR, TOP_RATED }

extension MovieRouteExtension on MovieRoute {
  String get getRoute {
    switch (this) {
      case MovieRoute.UPCOMING:
        return '/movie/upcoming';
      case MovieRoute.POPULAR:
        return '/movie/popular';
      case MovieRoute.TOP_RATED:
        return '/movie/top_rated';
      case MovieRoute.NOW_PLAYING:
        return '/movie/now_playing';
    }
  }
}
