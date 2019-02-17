import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'libs/localize.dart';

import 'project/globals.dart' as globals;
import 'project/constants.dart';

import 'package:d1090a/pages/splash.dart';
import 'package:d1090a/pages/mainMenu.dart';
import 'package:d1090a/pages/firstLaunch/enterHost.dart';
import 'package:d1090a/pages/firstLaunch/confirmHost.dart';

void main() => runApp(
	MaterialApp(
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
	)
);
