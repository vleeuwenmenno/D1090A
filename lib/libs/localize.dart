import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localize 
{  
	Localize(this.locale);  

	final Locale locale;  

	static Localize of(BuildContext context) 
	{  
		return Localizations.of<Localize>(context, Localize);  
	}  

	Map<String, String> _sentences;  

	Future<bool> load() async 
	{
		String data = await rootBundle.loadString('assets/i18n/${this.locale.languageCode}_${this.locale.countryCode}.json');
		Map<String, dynamic> _result = json.decode(data);

		this._sentences = new Map();
		
		_result.forEach((String key, dynamic value) 
		{
			this._sentences[key] = value.toString();
		});

		return true;
	}

	String trans(String key) 
	{  
		return this._sentences[key];  
	}  
}

class LocalizeDelegate extends LocalizationsDelegate<Localize> 
{  
	const LocalizeDelegate();  

	@override  
	bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);  

	@override  
	Future<Localize> load(Locale locale) async 
	{  
		if(isSupported(locale))
		{
			Localize localizations = new Localize(locale);  
			await localizations.load();  

			print("Load ${locale.languageCode}");  

			return localizations;  
		}
		else
		{
			Localize localizations = new Localize(new Locale("en", "US"));
			await localizations.load();

			print("Language ${locale.languageCode} not supported using default en-US");

			return localizations;
		}
	}  

	@override  
	bool shouldReload(LocalizeDelegate old) => false;  
}