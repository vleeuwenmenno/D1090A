// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:d1090a/libs/localize.dart';

import 'package:d1090a/project/globals.dart' as globals;
import 'package:d1090a/project/constants.dart';

import 'package:d1090a/pages/splash.dart';
import 'package:d1090a/pages/mainMenu.dart';
import 'package:d1090a/pages/firstLaunch/enterHost.dart';
import 'package:d1090a/pages/firstLaunch/confirmHost.dart';

void main() 
{
	testWidgets('Counter increments smoke test', (WidgetTester tester) async 
	{
		// Build our app and trigger a frame.
		await tester.pumpWidget(MaterialApp(
			supportedLocales:
			[
				const Locale('en', 'US')
			],
			localizationsDelegates: 
			[  
				const LocalizeDelegate(),  
				GlobalMaterialLocalizations.delegate,  
				GlobalWidgetsLocalizations.delegate  
			],
			localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) 
			{
				globals.deviceLocale = locale;

				for (Locale supportedLocale in supportedLocales) 
				{
					if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) 
					{  
						return supportedLocale;  
					}
				}
				
				return supportedLocales.first;  
			},
			theme: ThemeData(primaryColor: Const.dustyTeal, accentColor: Const.sunflowerYellow),
			debugShowCheckedModeBanner: false,
			initialRoute: '/',
			routes: {
				'/': (context) => Splash(),
				'/mainMenu': (context) => MainMenu(),
				'/firstLaunch/enterHost': (context) => EnterHost(),
				'/firstLaunch/confirmHost': (context) => ConfirmingHost(),
			},
		));
	});
}
