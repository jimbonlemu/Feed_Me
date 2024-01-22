import 'package:bhedhuk_app/data/models/list_restaurant.dart';
import 'package:bhedhuk_app/data/models/restaurant.dart';
import 'package:bhedhuk_app/pages/favorites_detail_page.dart';
import 'package:bhedhuk_app/pages/feed_detail_page.dart';
import 'package:bhedhuk_app/pages/navbar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const BhedhukApp());
}

class BhedhukApp extends StatelessWidget {
  const BhedhukApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Bhedhuk App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: NavBarPage.route,
      routes: {
        NavBarPage.route: (context) => const NavBarPage(),
        FavoritesDetailPage.route: (context) => FavoritesDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
        FeedDetailPage.route: (context) => FeedDetailPage(
              restaurantId: ModalRoute.of(context)?.settings.arguments
                  as ListOfRestaurant,
            ),
      },
    );
  }
}

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List of Resto'),
        ),
        body: Column(
          children: [
            _buildList(context),
          ],
        ));
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<ListOfRestaurant>(
      future: fetchListOfRestaurant(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data!.restaurants[index];
                return ListTile(
                  title: Text(restaurant.getId),
                  trailing: Image.network(restaurant.getPictureId),
                  subtitle: Text('${restaurant.getRating}'),
                  leading: Text('${restaurant.getMenuFoods}'),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');

          return Text("${snapshot.error}");
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, Restaurant resto) {
    return Material(
      child: ListTile(
        title: Text(resto.id),
        subtitle: Text(resto.name),
      ),
    );
  }
}
