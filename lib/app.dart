import 'package:flutter/material.dart';

import 'screens/categories/categories.dart';
import 'screens/home/home.dart';
import 'widgets/tab_item.dart';

GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final List<TabItem> tabItems = [
    TabItem(
      title: 'Home',
      iconData: Icons.home,
      navigatorKey: GlobalKey<NavigatorState>(),
      page: Home(),
    ),
    TabItem(
      title: 'Categories',
      iconData: Icons.view_module,
      navigatorKey: GlobalKey<NavigatorState>(),
      page: Categories(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentTab = tabItems[_currentIndex];
    return WillPopScope(
      onWillPop: () async =>
          !await currentTab.navigatorKey.currentState.maybePop(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: "New Subscription",
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: IndexedStack(
          index: _currentIndex,
          children: tabItems
              .map(
                _buildIndexedPageFlow,
              )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: navBarGlobalKey,
          currentIndex: _currentIndex,
          items: tabItems
              .map(
                (item) => BottomNavigationBarItem(
                  label: item.title,
                  icon: Icon(item.iconData),
                ),
              )
              .toList(),
          onTap: (newIndex) {
            setState(
              () {
                if (_currentIndex != newIndex) {
                  _currentIndex = newIndex;
                } else {
                  currentTab.navigatorKey.currentState
                      .popUntil((route) => route.isFirst);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildIndexedPageFlow(TabItem tabItem) => Navigator(
        key: tabItem.navigatorKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (context) => tabItem.page,
        ),
      );
}
