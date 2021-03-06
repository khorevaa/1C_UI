﻿
Процедура ПередЗаписью(Отказ)
	
	УстановитьНаименованиеПоУмолчанию();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНаименованиеПоУмолчанию()
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ТЧСвойства.Свойство,
	|	ТЧСвойства.Значение
	|ПОМЕСТИТЬ СвойстваОбъекта
	|ИЗ
	|	&ДополнительныеРеквизиты КАК ТЧСвойства
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СвойстваОбъекта.Значение,
	|	ДополнительныеРеквизитыИСведения.Заголовок
	|ИЗ
	|	СвойстваОбъекта КАК СвойстваОбъекта
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПланВидовХарактеристик.ДополнительныеРеквизитыИСведения КАК ДополнительныеРеквизитыИСведения
	|		ПО СвойстваОбъекта.Свойство = ДополнительныеРеквизитыИСведения.Ссылка");
	Запрос.УстановитьПараметр("ДополнительныеРеквизиты", ДополнительныеРеквизиты);
	Результат = Запрос.Выполнить().Выгрузить();
	
	Наименование = "";
	Для каждого СтрокаСвойства Из Результат Цикл
		Наименование = Наименование + ", " + (СтрокаСвойства.Заголовок) + " - " + Строка(СтрокаСвойства.Значение);
	КонецЦикла;
	
	ИмяИнвестиции = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидИнвестиции, "Наименование");
	
	Наименование = ИмяИнвестиции + Наименование;
	
КонецПРоцедуры
