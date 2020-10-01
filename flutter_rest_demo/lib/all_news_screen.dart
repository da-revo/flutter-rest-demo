
import 'package:flutter/material.dart';
import 'package:flutter_rest_demo/item_screen.dart';
import 'package:flutter_rest_demo/network/api.dart';
import 'package:flutter_rest_demo/models/news.dart';

class AllNewsScreen extends StatefulWidget {
	const AllNewsScreen({
		Key key,
	}) : super(key: key);

  @override
  _AllNewsScreenState createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {

	var _scaffoldKey = GlobalKey<ScaffoldState>();

	News _news;

	void fetchAllNews() async{
		var fetchedNews = await getAllNews();
		setState(() {
			_news = fetchedNews;
		});
	}

	@override
  void initState() {
		fetchAllNews();

		super.initState();
  }

	@override
	Widget build(BuildContext context) {

		return Scaffold(

			appBar: AppBar(
				title: Text('Fake News App'),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: fetchAllNews,
				tooltip: 'Refresh',
				child: Icon(Icons.refresh),
			),

			key: _scaffoldKey,
			body: ListView.builder(
				padding: const EdgeInsets.only(bottom: 100),
				itemCount: _news==null ? 0 : _news.items.length,
				itemBuilder: (context, index) {
					return NewsListTile(
						id: index,
						image: _news.items[index].image,
						headline: _news.items[index].head,
						body: _news.items[index].body,
					);
				},
			),
		);
	}
}

class NewsListTile extends StatelessWidget {
	const NewsListTile({
		Key key,
		@required this.id,
		@required this.image,
		@required this.headline,
		@required this.body,
	}) : super(key: key);

	final int id;
	final String image;
	final String headline;
	final String body;

	@override
	Widget build(BuildContext context) {

		return ListTile(
			onTap: () {
				Navigator.push(
					context,
					MaterialPageRoute(builder: (context) => ItemScreen( givenID: id)),
				);
			},
			leading: CircleAvatar(
			  child: Image.network(image),
			),
			title: Text(
				headline,
				style: TextStyle(fontSize: Theme.of(context).textTheme.headline6.fontSize),
				overflow: TextOverflow.ellipsis,
			),
			subtitle: Text(
				body,
			),

		);
	}
}
