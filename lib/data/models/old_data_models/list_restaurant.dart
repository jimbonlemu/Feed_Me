import 'package:bhedhuk_app/data/models/old_data_models/restaurant.dart';
import 'package:bhedhuk_app/utils/model_parser.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ListOfRestaurant {
  final List<Restaurant> restaurants;

  ListOfRestaurant({required this.restaurants});

  factory ListOfRestaurant.fromJson(Map<String, dynamic> parsedJson) {
    return ListOfRestaurant(
      restaurants: parser(parsedJson['restaurants'], Restaurant.fromJson),
    );
  }

  ListOfRestaurant sublist(int start, int end) {
    return ListOfRestaurant(
      restaurants: restaurants.sublist(start, end),
    );
  }
}

Future<ListOfRestaurant> fetchListOfRestaurant() async {
  await Future.delayed(const Duration(seconds: 2));
  final response = await rootBundle.loadString('assets/local_restaurant.json');

  final data = jsonDecode(response);
  return ListOfRestaurant.fromJson(data);
}