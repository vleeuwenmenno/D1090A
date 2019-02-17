import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:d1090a/libs/localize.dart';
import 'package:d1090a/project/constants.dart';

import 'package:d1090a/project/globals.dart' as globals;

class Splash extends StatefulWidget 
{
	@override
	SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin 
{

	@override
  	void initState()
	{
		super.initState();

		SharedPreferences.getInstance().then((SharedPreferences prefs) 
		{
			String host = prefs.getString("dump1090.host");

			/// Continue out of the splash screen after x:seconds
			/// But we must check if the user is new
			if (host != null && host.isNotEmpty)
			{
				globals.hostUrl = host;
				
				/// Go to main menu
				new Future.delayed(Duration(seconds: 2), () 
				{
					Navigator.pushReplacementNamed(context, '/mainMenu');
				});
			}
			else
			{
				/// Go to first launch
				new Future.delayed(Duration(seconds: 2), () 
				{
					Navigator.pushReplacementNamed(context, '/firstLaunch/enterHost');
				});
			}
		});
	}

	@override
	Widget build(BuildContext context) 
	{
		return Scaffold(
			body: Stack(
				children: <Widget>
				[
					/// App logo
					Center(
						child:
							Container(
								width: 192,
								child: FractionallySizedBox(
									heightFactor: 0.28,
									child:
										SvgPicture.asset(
											"assets/icons/appIcon.svg", 
											width: 192
										),
									),
								alignment: FractionalOffset(0.5, 0.25),
							),
					),

					Center(
						child:
							Container(
								child: 
									Text(
										Localize.of(context).trans("appName"),
										textAlign: TextAlign.center,
										style: TextStyle(
											color: Const.black,
											fontWeight: FontWeight.w400,
											fontFamily: "Roboto",
											fontStyle:  FontStyle.normal,
											fontSize: 22,
										),
									),
								alignment: FractionalOffset(0.5, 0.55),
							),
					),

					/// Random quote
					Column(
						mainAxisAlignment: MainAxisAlignment.end,
						children: <Widget>
						[
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>
								[
									Container(
										child: 
											Container(
												margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
												child: Text(
													Localize.of(context).trans("splash.quote"),
													style: const TextStyle(
														color: Const.black,
														fontWeight: FontWeight.w400,
														fontFamily: "Roboto",
														fontStyle:  FontStyle.normal,
														fontSize: 14,
													),
													textAlign: TextAlign.center
												)
											),
									)
								]
							)
						]
					),
				]
			)
		);
	}
}