import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:d1090a/libs/planeFinder.dart';
import 'package:d1090a/project/globals.dart' as globals;

class MainMenu extends StatefulWidget 
{
	@override
	MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> with SingleTickerProviderStateMixin 
{
	PlaneFinder pf;

	@override
	void initState()
	{
		super.initState();

 		Navigator.popUntil(context, ModalRoute.withName('/mainMenu'));

		pf = new PlaneFinder(new Duration(seconds: 1), globals.hostUrl, onUpdated: ()
		{
			print(pf.user.localTime);
		});

		pf.start();
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
			body: new FlutterMap(
				options: new MapOptions(
					center: new LatLng(51.5, -0.09),
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
			)
		);
	}
}