import 'dart:convert';

import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class PlaneFinder
{
	/// Public fields
	final Duration updateInterval;

	final String host;

	User user;

	List<dynamic> aircraft = [];

	VoidCallback onUpdated;

	/// Public fields ^^^
	
	/// Private fields
	
	bool _active = false;

	/// Private fields ^^^

	PlaneFinder(this.updateInterval, this.host, { this.onUpdated });

	/// Prepares the class and waits for the first data to receive
	Future<bool> init() async
	{
		await _fetchPost(host).then((http.Response s) 
		{
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
								this.aircraft.clear();
								v.forEach((dynamic key, dynamic value) 
								{
									this.aircraft.add(value);
								});
							}
							else if (k == "user")
							{
								DateTime uTime;
								LatLng uLoc = new LatLng(0, 0);

								v.forEach((dynamic key, dynamic value) 
								{
									if (key == "user_lat")
										uLoc.latitude = double.parse(value);

									else if (key == "user_lon")
										uLoc.longitude = double.parse(value);
									
									else if (key == "user_time")
										uTime = DateTime.fromMillisecondsSinceEpoch((value * 1000).round());
								});

								this.user = new User(uTime, uLoc);
							}
						});

						if (onUpdated != null)
							onUpdated();
					}
					catch (e)
					{
						print(e);
					}
				}
				catch (e)
				{
					print(e);
				}
			}
		});

		start();
		return true;
	}

	/// Start updating the Aircraft list every [updateInterval]
	void start() async
	{
		_active = true;
		while (_active)
		{
			await new Future.delayed(Duration(seconds: updateInterval.inSeconds)).then((n) async
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
									this.aircraft.clear();
									v.forEach((dynamic key, dynamic value) 
									{
										this.aircraft.add(value);
									});
								}
								else if (k == "user")
								{
									DateTime uTime;
									LatLng uLoc = new LatLng(0, 0);

									v.forEach((dynamic key, dynamic value) 
									{
										if (key == "user_lat")
											uLoc.latitude = double.parse(value);

										else if (key == "user_lon")
											uLoc.longitude = double.parse(value);
										
										else if (key == "user_time")
											uTime = DateTime.fromMillisecondsSinceEpoch((value * 1000).round());
									});

									this.user = new User(uTime, uLoc);
								}
							});

							if (onUpdated != null)
								onUpdated();
						}
						catch (e)
						{
							print(e);
						}
					}
					catch (e)
					{
						print(e);
					}
				}
			});
		}
	}

	/// Stops the update process
	void stop()
	{
		_active = false;
	}

	/// Fetch data with GET request [url]
    ///
    /// [url] is the actual requested path to the remote server
	Future<http.Response> _fetchPost(String url)
    {
		return http.get(url);
	}
}

class User
{
	final DateTime localTime;
	final LatLng location;

	User(this.localTime, this.location);
}