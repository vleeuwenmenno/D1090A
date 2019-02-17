import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:d1090a/project/constants.dart';
import 'package:d1090a/project/globals.dart' as globals;
import 'package:d1090a/libs/localize.dart';



class EnterHost extends StatefulWidget 
{
	@override
	EnterHostState createState() => EnterHostState();
}

class EnterHostState extends State<EnterHost> with SingleTickerProviderStateMixin 
{
	@override
	Widget build(BuildContext context) 
	{
		return Scaffold(
			body: new Stack(
				children: <Widget>
				[
					/// Welcome text
					Center(
						child:
							Container(
								child: 
									Text(
										Localize.of(context).trans("enterHost.welcome") + Localize.of(context).trans("appName"),
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

					/// Input label
					Center(
						child:
							Container(
								margin: EdgeInsets.only(left: 16, bottom: 16),
								child: 
									Text(
										Localize.of(context).trans("enterHost.inputLabel"),
										textAlign: TextAlign.center,
										style: TextStyle(
											color: Const.black,
											fontWeight: FontWeight.w400,
											fontFamily: "Roboto",
											fontStyle:  FontStyle.normal,
											fontSize: 15,
										),
									),

								alignment: FractionalOffset(0.0, 0.616),
							),
					),

					/// Input box
					Center(
						child:
							Container(
								margin: EdgeInsets.symmetric(horizontal: 16),
								child: 
									TextField(
										controller: new TextEditingController(text: globals.hostUrl),
										decoration: InputDecoration(
											hintText: Localize.of(context).trans("enterHost.hostInputHint")
										),
										onChanged: (String text)
										{
											globals.hostUrl = text;
										},
									),

								alignment: FractionalOffset(0.5, 0.644),
							),
					),

					/// Bottom bar
					Column(
						mainAxisAlignment: MainAxisAlignment.end,
						children: <Widget>
						[
							Container(
								width: MediaQuery.of(context).size.width,
								height: 52,
								decoration: BoxDecoration(
									color: Const.dustyTeal
								),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.end,
									children: <Widget>
									[
										Container(
											margin: EdgeInsets.only(right: 12.7),
											child: FlatButton(
												child: Text(
													Localize.of(context).trans("enterHost.nextBtn"),
													    style: TextStyle(
															color: Const.white,
															fontWeight: FontWeight.w500,
															fontFamily: "Roboto",
															fontStyle:  FontStyle.normal,
															fontSize: 14
														)
												),
												onPressed: () async
												{
													Navigator.pushNamed(context, '/firstLaunch/confirmHost').then((s) async
													{
														await showDialog(
															context: context,
															builder: (BuildContext c)
															{
																return AlertDialog(
																	content: new Text((s != null ? s : "Unknown error")),
																	actions: <Widget>
																	[
																		// usually buttons at the bottom of the dialog
																		new FlatButton(
																			child: new Text("Dismiss"),
																			onPressed: () 
																			{
																				Navigator.of(context).pop();
																			},
																		),
																	],
																);
															}
														);
													});
												},
											)
										)
									]
								)
							)
						]
					)
				]
			)
		);
	}
}