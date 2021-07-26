import 'package:flutter/material.dart';
import 'package:movinfo/core/constants/app_constants.dart';
import 'package:movinfo/core/constants/navigation_constants.dart';
import 'package:movinfo/core/init/navigation/navigate_service.dart';
import 'package:movinfo/view/Movie/movie_list.dart';
import 'package:movinfo/view/TV/tv_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  late ScrollController _scrollController;

  var tabsName = ['Filmler', 'Diziler'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar,
      bottomNavigationBar: buildBottomNavigationBar,
      body: buildTabBarView,
    );
  }

  TabBarView get buildTabBarView {
    return TabBarView(
      controller: _tabController,
      children: [
        buildMovieTabs,
        buildTVTabs,
      ],
    );
  }

  IndexedStack get buildTVTabs {
    return IndexedStack(index: selectedIndex, children: [
      TVList(
        path: '/tv/airing_today',
      ),
      TVList(
        path: '/tv/on_the_air',
      ),
      TVList(
        path: '/tv/popular',
      ),
      TVList(
        path: '/tv/top_rated',
      )
    ]);
  }

  IndexedStack get buildMovieTabs {
    return IndexedStack(index: selectedIndex, children: [
      MovieList(
        path: '/movie/upcoming',
      ),
      MovieList(
        path: '/movie/now_playing',
      ),
      MovieList(
        path: '/movie/popular',
      ),
      MovieList(
        path: '/movie/top_rated',
      )
    ]);
  }

  AppBar get buildAppBar {
    return AppBar(
        leading: IconButton(
            onPressed: () => NavigationService.instance
                .navigateToPage(NavigationConstants.SETTINGS, ''),
            icon: Icon(Icons.settings)),
        actions: [
          IconButton(
              onPressed: () => NavigationService.instance.navigateToPage(
                  _tabController.index == 0
                      ? NavigationConstants.MOVIE_SEARCH
                      : NavigationConstants.TV_SEARCH,
                  ''),
              icon: Icon(Icons.search)),
        ],
        title: Text(tabsName[_tabController.index]),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [Icon(Icons.movie), Icon(Icons.tv)],
        ));
  }

  buildTab(String title, IconData icon) => Tab(
        icon: Icon(icon),
        text: title,
      );

  buildTabBar() {
    return PreferredSize(
        child: TabBar(
          controller: _tabController,
          tabs: [
            Icon(
              Icons.movie_creation_outlined,
            ),
            Icon(Icons.tv_off_outlined)
          ],
        ),
        preferredSize: Size.fromHeight(kToolbarHeight));
  }

  BottomNavigationBar get buildBottomNavigationBar {
    return BottomNavigationBar(
      items: [
        builddBottomNavigationBarItem(
            Icons.update_outlined, 'Yakında', Colors.deepPurpleAccent),
        builddBottomNavigationBarItem(
            Icons.play_circle_outline, 'Yayında', Colors.deepPurpleAccent),
        builddBottomNavigationBarItem(
            Icons.people_outline_sharp, 'Popüler', Colors.deepPurpleAccent),
        builddBottomNavigationBarItem(
            Icons.how_to_vote_sharp, 'En İyiler', Colors.deepPurpleAccent),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white70,
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem builddBottomNavigationBarItem(
      IconData icon, String label, MaterialAccentColor color) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
      backgroundColor: color,
    );
  }

  void _onItemTapped(int value) {
    selectedIndex = value;
    setState(() {});
  }
}
