import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:d1090a/libs/planeFinder.dart';
import 'package:d1090a/project/globals.dart' as globals;
import 'package:d1090a/project/constants.dart';

class MainMenu extends StatefulWidget 
{
	@override
	MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> with SingleTickerProviderStateMixin 
{
	@override
	void initState()
	{
		super.initState();

 		Navigator.popUntil(context, ModalRoute.withName('/mainMenu'));
	}

	@override
	Widget build(BuildContext context) 
	{
		//Force portrait mode
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);

		return Scaffold(
			body: Stack(
				children: <Widget>
				[
					FlutterMap(
						options: new MapOptions(
							center: new LatLng(globals.planeFinder.user.location.latitude, globals.planeFinder.user.location.longitude),
							zoom: 13.0,
						),
						layers: [
							new TileLayerOptions(
								urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
							),
							new MarkerLayerOptions(
							markers: [],
							),
						],
					),

					Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
							Container(
								height: (MediaQuery.of(context).size.height / 100) * 13.8,
								decoration: BoxDecoration(
									color: Const.dustyTeal
								),
								child: Row(children: <Widget>
								[

								])
							),
						]
					),
				]
			)
		);
	}
}