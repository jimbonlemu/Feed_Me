import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'interface_api_service.dart';
import '../../utils/response_decoder.dart';
import '../models/list_of_restaurant_object_api_response.dart';
import '../models/object_customer_review_api_response.dart';
import '../models/object_restaurant_detail_api_response.dart';

class ApiService extends InterfaceApiService {
  ApiService._internal();

  static final ApiService _instanceApiService = ApiService._internal();

  factory ApiService() => _instanceApiService;

  static final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  static const String _getListOfRestaurant = 'list';
  static const String _getDetailOfRestaurant = 'detail/';
  static const String _searchListOfRestaurant = 'search?q=';
  static const String _postReview = 'review';
  @override
  Future<ListOfRestaurantObjectApiResponse> getListOfRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _getListOfRestaurant));
    return responseDecoder(
        response, ListOfRestaurantObjectApiResponse.fromJson);
  }

  @override
  Future<ObjectOfRestaurantDetailApiResponse> getRestaurantDetail(
      String restaurantId) async {
    final response = await http
        .get(Uri.parse(_baseUrl + _getDetailOfRestaurant + restaurantId));
    return responseDecoder(
        response, ObjectOfRestaurantDetailApiResponse.fromJson);
  }

  @override
  Future<ListOfRestaurantObjectApiResponse> searchListOfRestaurant(
      String keyword) async {
    final response =
        await http.get(Uri.parse(_baseUrl + _searchListOfRestaurant + keyword));
    return responseDecoder(
        response, ListOfRestaurantObjectApiResponse.fromJson);
  }

  @override
  Future<ObjectOfCustomerReviewApiResponse> postCustomerReview(
      String restaurantId, String reviewerName, String reviewComment) async {
    final response = await http.post(
      Uri.parse(_baseUrl + _postReview),
      headers: <String, String>{
        "Content-Type": " application/json ; charset=UTF-8"
      },
      body: jsonEncode(<String, String>{
        "id": restaurantId,
        "name": reviewerName,
        "review": reviewComment,
      }),
    );
    return ObjectOfCustomerReviewApiResponse.fromJson(
        jsonDecode(response.body));
  }
}
