
import 'package:http/http.dart' as http;

import 'dart:async';

import '../models/news.dart';

//TODO: change IP address
String authority='192.168.43.22:3000';
String basePath = '';
String url = 'http://$authority' + basePath;


Future<Item> getNewsItem(int id) async {

	var uri = Uri.http(authority, '$basePath/item/$id');

	print('GET $uri');
	final response = await http.get(
		uri,
	).timeout(const Duration(seconds: 15));

	print("response.body is not null? " + (response.body != null).toString());

	if (response.statusCode == 200) {
		return itemFromJson(response.body);
	} else {
		throw Exception('Failed to load news item');
	}
}


Future<News> getAllNews() async {
	var uri = Uri.http(authority, '$basePath/all');
	print('GET $uri');
	final response = await http.get(
		uri,
	).timeout(const Duration(seconds: 15));

	print("response.body is not null? " + (response.body != null).toString());

	if (response.statusCode == 200) {
		return newsFromJson(response.body) ;
	} else {
		throw Exception('Failed to load all the news');
	}
}