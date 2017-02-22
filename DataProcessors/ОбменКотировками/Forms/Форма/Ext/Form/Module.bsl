﻿&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПутьКФайлуНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбора.Фильтр                  = НСтр("ru = 'файд JSON'") + " (*.json)|*.json";
	ДиалогВыбора.Заголовок               = НСтр("ru = 'Выберите файл обмена'");
	ДиалогВыбора.ПредварительныйПросмотр = Ложь;
	ДиалогВыбора.МножественныйВыбор      = Ложь;
	ДиалогВыбора.Расширение              = "json";
	ДиалогВыбора.ИндексФильтра           = 0;
	ДиалогВыбора.ПолноеИмяФайла          = ?(ПустаяСтрока(Элемент.ТекстРедактирования),
		"1c_quotes.json", Элемент.ТекстРедактирования);
	ДиалогВыбора.ПроверятьСуществованиеФайла = Ложь;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыборФайлаДляВыгрузкиЗавершение", ЭтотОбъект);
	ДиалогВыбора.Показать(ОписаниеОповещения);
	
	//
	//ОповещениеПомещениеФайла = Новый ОписаниеОповещения("ПомещениеФайлаЗавершение", ЭтаФорма);
	//НачатьПомещениеФайла(ОповещениеПомещениеФайла, , "quotes.json", Истина, УникальныйИдентификатор);
	//
КонецПроцедуры

&НаКлиенте
Процедура Выгрузить(Команда)
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ВыгрузитьКотировки();
	
КонецПроцедуры

&НаКлиенте
Процедура Загрузить(Команда)
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	
	//ЗагрузитьКотировки();
	
	ЗагрузитьКотировкиТкемп(ПолноеИмяФайла);
	
КонецПроцедуры

Процедура ЗагрузитьКотировкиТкемп(Параметры)
	
	
	ЧтениеJson = Новый ЧтениеJSON;
	ЧтениеJson.ОткрытьФайл(Параметры);
	СериализаторXDTO.ПрочитатьJSON(ЧтениеJson);
	
	
	
КонецПроцедуры


#КонецОбласти

#Область АсинхронныеПроцедуры

&НаКлиенте
Процедура ВыборФайлаДляВыгрузкиЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено Тогда
		
		ПолноеИмяФайла = ВыбранныеФайлы.Получить(0);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область АбстракцияФоновогоЗадания

&НаКлиенте
Процедура ЗапуститьВыполнениеЗадания(НаименованиеЗадания, ИмяПроцедуры, ПараметрыЗадания = Неопределено)

	Попытка
		Результат = ЗапуститьВыполнениеВФоне(УникальныйИдентификатор, НаименованиеЗадания, ПараметрыЗадания, ИмяПроцедуры);
		АдресХранилища = Результат.АдресХранилища;
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		
		Если Не Результат.ЗаданиеВыполнено Тогда
			ПродолжитьВыполнениеЗадания();
		Иначе
			РезультатВыполненияЗадания();
		КонецЕсли;
	Исключение
		УправлениеРеквизитамиАктивностиВыполнения(Истина, ИнформацияОбОшибке().Описание);
	КонецПопытки;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗапуститьВыполнениеВФоне(ИдФормы, НаименованиеЗадания, ПараметрыЗадания, ИмяПроцедуры)
	
	Возврат ДлительныеОперации.ЗапуститьВыполнениеВФоне
		(ИдФормы, ИмяПроцедуры, ПараметрыЗадания, НаименованиеЗадания);
	
КонецФункции

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	Попытка 
		Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда
			РезультатВыполненияЗадания();
		Иначе
			ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
			ПодключитьОбработчикОжидания(
				"Подключаемый_ПроверитьВыполнениеЗадания", ПараметрыОбработчикаОжидания.ТекущийИнтервал, Истина);
		КонецЕсли
	Исключение
		
		ИнформацияОбОшибке = ПолучитьИнфоНаСервере(ИдентификаторЗадания);
		УправлениеРеквизитамиАктивностиВыполнения(Истина, ИнформацияОбОшибке);
	КонецПопытки;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

&НаКлиенте
Процедура ПродолжитьВыполнениеЗадания()
	
	ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
	ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
	
	УправлениеРеквизитамиАктивностиВыполнения(Ложь, "ЗаданиеВыполняется");
	
КонецПроцедуры

&НаКлиенте
Функция РезультатВыполненияЗадания()
	
	Результат = ПолучитьИзВременногоХранилища(АдресХранилища);
	
	Если Результат.Команда = "Выгрузка" Тогда
		ФайлВыгрузки = Результат.Файл;
		ФайлВыгрузки.Записать(ПолноеИмяФайла);
	КонецЕсли;
	
	УправлениеРеквизитамиАктивностиВыполнения(Истина, "");
	
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьИнфоНаСервере(ИдЗадания)
	
	Задание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(Новый УникальныйИдентификатор(ИдЗадания));
	
	Возврат Задание.ИнформацияОбОшибке.Описание;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыФункции

&НаКлиенте
Процедура ВыгрузитьКотировки()
	
	НаименованиеЗадания = "ru = 'Выгрузка котировок'";
	ИмяПроцедуры = "Обработки.ОбменКотировками.СформироватьФайлВыгрузки";
	
	ЗапуститьВыполнениеЗадания(НаименованиеЗадания, ИмяПроцедуры);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьКотировки()
	
	НаименованиеЗадания = "ru = 'Загрузка котировок'";
	ИмяПроцедуры = "Обработки.ОбменКотировками.ЗагрузитьКотировки";
	
	ЗапуститьВыполнениеЗадания(НаименованиеЗадания, ИмяПроцедуры, ПолноеИмяФайла);
	
КонецПроцедуры

&НаКлиенте
Процедура УправлениеРеквизитамиАктивностиВыполнения(ЗаданиеЗавершено, КодСтатуса)
	
	Элементы.КартинкаВыполнения.Видимость = Не ЗаданиеЗавершено;
	Элементы.КартинкаОК.Видимость = ЗаданиеЗавершено;
	Элементы.ТекстСтатус.Заголовок = КодСтатуса;
	Элементы.Выгрузить.Доступность = ЗаданиеЗавершено;
	Элементы.Загрузить.Доступность = ЗаданиеЗавершено;

КонецПроцедуры



#КонецОбласти