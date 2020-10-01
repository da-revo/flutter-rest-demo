// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class News {
	News({
		this.items,
	});

	List<Item> items;

	factory News.fromJson(Map<String, dynamic> json) => News(
		items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
	);

	Map<String, dynamic> toJson() => {
		"items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
	};
}

class Item {
	Item({
		this.head,
		this.body,
		this.image,
	});

	String head;
	String body;
	String image;

	factory Item.fromJson(Map<String, dynamic> json) => Item(
		head: json["head"] == null ? null : json["head"],
		body: json["body"] == null ? null : json["body"],
		image: json["image"] == null ? null : json["image"],
	);

	Map<String, dynamic> toJson() => {
		"head": head == null ? null : head,
		"body": body == null ? null : body,
		"image": image == null ? null : image,
	};
}
