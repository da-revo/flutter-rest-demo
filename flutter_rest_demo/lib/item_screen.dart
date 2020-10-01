
import 'package:flutter/material.dart';
import 'package:flutter_rest_demo/models/news.dart';
import 'package:flutter_rest_demo/network/api.dart';

class ItemScreen extends StatefulWidget {
	const ItemScreen({
		Key key,
		this.givenID,
	}) : super(key: key);

	final int givenID;

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {

	Item _item;

	void fetchItem() async{
		var fetchedItem = await getNewsItem(widget.givenID);
		setState(() {
			_item = fetchedItem;
		});
	}

	@override
	void initState() {
		fetchItem();

		super.initState();
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: Text('Fake News'+widget.givenID.toString()),
			),
			body: _item==null ? Container() : Container(
				child: SingleChildScrollView(
				  child: Column(
				    children: [
				      Text(_item.head, style: TextStyle(fontSize: Theme.of(context).textTheme.headline6.fontSize),),
							Image.network(_item.image),
							Text(_item.body),
				    ],
				  ),

				),
			),
		);
  }
}



