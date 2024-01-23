import 'package:bhedhuk_app/pages/favorites_list_page.dart';
import 'package:bhedhuk_app/pages/feed_list_page.dart';
import 'package:bhedhuk_app/widgets/custom_alert_dialog_widget.dart';
import 'package:flutter/material.dart';

class NavBarPage extends StatefulWidget {
  static const route = '/navbar_page';

  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  final List<BottomNavigationBarItem> _navBarPageItem = [
     BottomNavigationBarItem(
      icon: Icon(Icons.feed),
      label: 'Feeds',
    ),
     BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
  ];

  final List<Widget> _listPage = [
    const FeedListPage(),
    const FavoritesListPage(),
  ];

  int _navBarIndex = 0;
  Future<bool> onWillPop() async {
    return await showDialog(
            context: context,
            builder: (context) => const CustomAlertDialog()) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: _listPage[_navBarIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: _navBarPageItem,
          currentIndex: _navBarIndex,
          onTap: (selected) {
            setState(() {
              _navBarIndex = selected;
            });
          },
        ),
      ),
    );
  }
}
