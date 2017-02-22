﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Параметр содержит список с элементами, которые должны быть показаны в левой части формы.
	Если Параметры.Свойство("ДоступныеПанели") Тогда
		ДоступныеПанели = Параметры.ДоступныеПанели;
	КонецЕсли;
	
	// Параметр содержит список с элементами, которые должны быть показаны в правой части формы.
	Если Параметры.Свойство("ВыбранныеПанели") Тогда
		ВыбранныеПанели = Параметры.ВыбранныеПанели;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДоступныеПанелиВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	СтандартнаяОбработка= Ложь;
	
	ЗначениеСтроки = Элементы.ДоступныеПанели.ТекущиеДанные;
	ДобавитьЗначениеНаПанель(ЗначениеСтроки, ВыбранныеПанели);
	
	ТекСтрока = Элементы.ДоступныеПанели.ТекущаяСтрока;
	УдалитьЗначениеСПанели(ТекСтрока, ДоступныеПанели);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбранныеПанелиВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ЗначениеСтроки = Элементы.ВыбранныеПанели.ТекущиеДанные;
	ДобавитьЗначениеНаПанель(ЗначениеСтроки, ДоступныеПанели);
	
	ТекСтрока = Элементы.ВыбранныеПанели.ТекущаяСтрока;
	УдалитьЗначениеСПанели(ТекСтрока, ВыбранныеПанели);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПанельДобавить(Команда)
	
	ЗначениеСтроки = Элементы.ДоступныеПанели.ТекущиеДанные;
	ДобавитьЗначениеНаПанель(ЗначениеСтроки, ВыбранныеПанели);
	
	ТекСтрока = Элементы.ДоступныеПанели.ТекущаяСтрока;
	УдалитьЗначениеСПанели(ТекСтрока, ДоступныеПанели);
	
КонецПроцедуры

&НаКлиенте
Процедура ПанельДобавитьВсе(Команда)
	
	Для каждого ЗначениеСтроки Из ДоступныеПанели Цикл
		
		ДобавитьЗначениеНаПанель(ЗначениеСтроки, ВыбранныеПанели);
		
	КонецЦикла;
	
	ДоступныеПанели.Очистить();
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьВсе(Команда)
	
	Для каждого ЗначениеСтроки Из ВыбранныеПанели Цикл
		
		ДобавитьЗначениеНаПанель(ЗначениеСтроки, ДоступныеПанели);
		
	КонецЦикла;
	
	ВыбранныеПанели.Очистить();
	
КонецПроцедуры

&НаКлиенте
Процедура СтандартныеНастройки(Команда)
	
	УстановитьСтандартныеНастройки();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОК(Команда)
	
	СохранитьДашбордыПользователя();
	
	ПоказатьДашбордыПользователю();
	
	Закрыть(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПрименить(Команда)
	
	СохранитьДашбордыПользователя();
	
	ПоказатьДашбордыПользователю();
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ДобавитьЗначениеНаПанель(СтрокаПанели, Панель)
	
	Если СтрокаПанели = Неопределено Тогда
		Возврат
	КонецЕсли;
	
	Панель.Добавить(СтрокаПанели.Значение, СтрокаПанели.Представление);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьЗначениеСПанели(ТекСтрока, Панель)
	
	Если ТекСтрока = Неопределено Тогда
		Возврат
	КонецЕсли;
	
	ИдСтроки = Панель.НайтиПоИдентификатору(ТекСтрока);
	
	Панель.Удалить(ИдСтроки);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСтандартныеНастройки()
	
	ВыбранныеПанели = Дашборды.ПолучитьСтандартные();
	ДоступныеПанели = Дашборды.ПолучитьНеактивные(ВыбранныеПанели);
	
КонецПроцедуры

Процедура СохранитьДашбордыПользователя()
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ПерсональныеНастройки", "АктивныеДашборды", ВыбранныеПанели, , ИмяПользователя());
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьДашбордыПользователю()
	
	Оповестить("НастройкаПанелейДашбордов", ВыбранныеПанели);
	
КонецПроцедуры


#КонецОбласти
