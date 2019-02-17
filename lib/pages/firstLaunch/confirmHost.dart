import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:validators/validators.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:d1090a/pages/mainMenu.dart';

import 'package:d1090a/libs/localize.dart';

import 'package:d1090a/project/constants.dart';
import 'package:d1090a/project/globals.dart' as globals;


class ConfirmingHost extends StatefulWidget 
{
	@override
	ConfirmingHostState createState() => ConfirmingHostState();
}

class ConfirmingHostState extends State<ConfirmingHost> with SingleTickerProviderStateMixin 
{
	bool secondTry = false;

	@override
	void initState()
	{
		super.initState();
	}

	@override
	Widget build(BuildContext context) 
	{
		executeAfterBuild();
		return Scaffold(
			body: Stack(
				children: <Widget>
				[
					/// Welcome text
					Center(
						child:
							Container(
								child: 
									Text(
										Localize.of(context).trans("confirmHost.titleText"),
										textAlign: TextAlign.center,
										style: TextStyle(
											color: Const.black,
											fontWeight: FontWeight.w400,
											fontFamily: "Roboto",
											fontStyle:  FontStyle.normal,
											fontSize: 22,
										),
									),
								alignment: FractionalOffset(0.5, 0.10),
							),
					),

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

					/// Loader text
					Column(
						mainAxisAlignment: MainAxisAlignment.end,
						children: <Widget>
						[
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>
								[
									SpinKitDoubleBounce(
										color: Const.dustyTeal,
										size: 32.0,
									)
								]
							),

							new Padding(padding: EdgeInsets.only(bottom: 8)),

							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>
								[
									Container(
										child: 
											Container(
												margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
												child: Text(
													Localize.of(context).trans("confirmHost.confirmingHost"),
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

	Future<void> executeAfterBuild() async 
	{
		await new Future.delayed(Duration(milliseconds: 1000), () async
		{
			String host = globals.hostUrl;
			if (isURL(host))
			{
				/// Missing protocol at the begin? Let's add https ourselves then
				if (!host.startsWith("https://") && !host.startsWith("http://"))
					host = "https://" + host;

				/// Missing ajax/aircraft at the end? Let's add it ourselves then
				if (!host.endsWith("ajax/aircraft"))
					host += (host.endsWith("/") ? "ajax/aircraft" : "/ajax/aircraft");

				globals.hostUrl = host;
				print("Testing host: " + host);

				try 
				{
					http.Response s = await _fetchPost(host);

					if (s != null && s.statusCode == 200)
					{
						dynamic json;
						try
						{
							json = jsonDecode(s.body);
							
							try 
							{
								json.forEach((dynamic k, dynamic v) 
								{
									if (k == "aircraft")
									{
										v.forEach((dynamic key, dynamic value) 
										{
											print (value);
										});
									}
								});
								
								/// This host seems to work, let's save it
								SharedPreferences.getInstance().then((SharedPreferences prefs) 
								{
									prefs.setString("dump1090.host", host).then((bool b) 
									{
										globals.hostUrl = host;

										/// Let's go to the main menu
										return Navigator.popAndPushNamed(context, '/mainMenu', result: Localize.of(context).trans("confirmHost.setupDone"));
									});
								});
							} 
							catch (e) 
							{
								Navigator.popAndPushNamed(context, "/firstLaunch/enterHost", result: Localize.of(context).trans("error.unexpectedJson"));
								return null;
							}
						}
						catch (e)
						{
							Navigator.popAndPushNamed(context, "/firstLaunch/enterHost", result: Localize.of(context).trans("error.noDump1090"));
							return null;
						}
					}
					else
						Navigator.popAndPushNamed(context, "/firstLaunch/enterHost", result: Localize.of(context).trans("error.hostUnreachable") + " (" + s.statusCode.toString() + ")");

					return null;
				} 
				catch (e) 
				{
					Navigator.popAndPushNamed(context, "/firstLaunch/enterHost", result: Localize.of(context).trans("error.hostUnreachable"));
					return null;
				}
			}
			else
				Navigator.popAndPushNamed(context, "/firstLaunch/enterHost", result: Localize.of(context).trans("error.hostIsUrlIsNotTrue"));

			return null;
		});
	}

	/// Fetch data with GET request [url]
    ///
    /// [url] is the actual requested path to the remote server
	Future<http.Response> _fetchPost(String url)
    {
		return http.get(url);
	}
}