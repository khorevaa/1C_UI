﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОсновнаяПлатежнаяСистема =  УправлениеНастройкамиПользователей.ПолучитьОсновнуюПлатежнуюСистему();
	ОсновнаяВалюта = УправлениеНастройкамиПользователей.ПолучитьОсновнуюВалюту();
	ОсновнойИсточникСредств = УправлениеНастройкамиПользователей.ПолучитьОсновнойИсточникСредств();
	ОбновлятьКурсыАвтоматически = УправлениеНастройкамиПользователей.ПолучитьПризнакОбновленияКурсов();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Записать(Команда)
	
	ЗаписатьДанные();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьДанные();
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьНастройкиДашбордов(Команда)
	
	СброситьНастройкиДашбордовНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗаписатьДанные()
	
	СохранитьНастройкиСервер();
	
КонецПРоцедуры

&НаСервере
Процедура СохранитьНастройкиСервер()
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ПерсональныеНастройки", "ОсновнаяПлатежнаяСистема", ОсновнаяПлатежнаяСистема, , ИмяПользователя());
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ПерсональныеНастройки", "ОсновнаяВалюта", ОсновнаяВалюта, , ИмяПользователя());
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ПерсональныеНастройки", "ОсновнойИсточникСредств", ОсновнойИсточникСредств, , ИмяПользователя());
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ПерсональныеНастройки", "ОбновлятьКурсыАвтоматически", ОбновлятьКурсыАвтоматически, ИмяПользователя());
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СброситьНастройкиДашбордовНаСервере()
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ПерсональныеНастройки", "АктивныеДашборды", Неопределено, , ИмяПользователя());
	
КонецПроцедуры

#КонецОбласти



