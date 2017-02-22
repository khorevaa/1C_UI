﻿// Получает дополнение периода  для интервала дат.
//
// Параметры:
//  Период  - Структура - содержит следующие значения:
//    *ДатаНачала     - Дата - дата начала интервала.
//    *ДатаОкончания  - Дата - дата окончания интервала.
//  Периодичность - Строка - интервал для периода (День, Месяц).
// 
// Возвращаемое значение:
//  ТаблицаЗначений -  таблица из одной колонки, каждая строка которой представляет собой дату интервала .
//
Функция ДополнениеПериодаСтарый(Период, Периодичность) Экспорт
	
	Цифры = Новый ТаблицаЗначений;
	
	ТипЧисло = Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(2,0)); 
	Цифры.Колонки.Добавить("Цифра", ТипЧисло);
	
	Для Счетчик = 0 По 9 Цикл
		
		Строка = Цифры.Добавить();
		Строка.Цифра = Счетчик;
		
	КонецЦикла;
	
	Запрос = Новый Запрос(
	 "ВЫБРАТЬ
	 |	Цифры.Цифра
	 |ПОМЕСТИТЬ Цифры
	 |ИЗ
	 |	&Цифры КАК Цифры
	 |;
	 |
	 |////////////////////////////////////////////////////////////////////////////////
	 |ВЫБРАТЬ
	 |	ДОБАВИТЬКДАТЕ(&НачалоПериода, ДЕНЬ, ВсеЦифры.Цифра - 1) КАК ДатаЗначениеИнтервала
	 |ИЗ
	 |	(ВЫБРАТЬ
	 |		1 + Цифры.Цифра + Цифры1.Цифра * 10 КАК Цифра
	 |	ИЗ
	 |		Цифры КАК Цифры,
	 |		Цифры КАК Цифры1) КАК ВсеЦифры
	 |ГДЕ
	 |	ДОБАВИТЬКДАТЕ(&НачалоПериода, ДЕНЬ, ВсеЦифры.Цифра - 1) <= &КонецПериода
	 |
	 |УПОРЯДОЧИТЬ ПО
	 |	ДатаЗначениеИнтервала");
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ДЕНЬ", Периодичность); 
	Запрос.УстановитьПараметр("Цифры", Цифры);
	Запрос.УстановитьПараметр("НачалоПериода", Период.ДатаНачала);
	Запрос.УстановитьПараметр("КонецПериода", Период.ДатаОкончания); 
	
	Результат = Запрос.Выполнить().Выгрузить();
	
	// Если переданный конец периода больше чем конец интервала запроса,
	// то добавляем его в конец таблицы.
	Результат.Индексы.Добавить("ДатаЗначениеИнтервала");
	Если Результат.Найти(Период.ДатаОкончания, "ДатаЗначениеИнтервала") = Неопределено Тогда
		СтрокаПериода = Результат.Добавить();
		СтрокаПериода.ДатаЗначениеИнтервала = Период.ДатаОкончания;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ДополнениеПериода(НачалоПериода, КонецПериода, Периодичность) Экспорт
	
	ТекущийПериод = НачалоДня(НачалоПериода);
	ДатаОкончания = НачалоДня(КонецПериода);
	
	Результат = Новый Массив;
	
	Пока ТекущийПериод < ДатаОкончания Цикл
		Результат.Добавить(ТекущийПериод);
		
		ТекущийПериод = СледующаяДатаПериода(ТекущийПериод, Периодичность);
	КонецЦикла;
	
	Результат.Добавить(ДатаОкончания);
	
	Возврат Результат;
	
КонецФункции

Функция СледующаяДатаПериода(ИсходныйПериод, Периодичность)
	
	Если Периодичность = "День" Тогда
		Возврат ИсходныйПериод + 86400;
	Иначе
		Возврат НачалоМесяца(ДобавитьМесяц(ИсходныйПериод, 1));
	КонецЕсли;
	
КонецФункции

Функция ТекстЗапросаСтоимостьКапитала() Экспорт
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ДоступныеСредстваОстаткиИОбороты.СуммаВВалютеКонечныйОстаток КАК СуммаВВалюте,
	|	ДоступныеСредстваОстаткиИОбороты.Валюта КАК Валюта,
	|	ДоступныеСредстваОстаткиИОбороты.Период,
	|	ДоступныеСредстваОстаткиИОбороты.Валюта.ЦветR КАК ЦветR,
	|	ДоступныеСредстваОстаткиИОбороты.Валюта.ЦветG КАК ЦветG,
	|	ДоступныеСредстваОстаткиИОбороты.Валюта.ЦветB КАК ЦветB
	|ПОМЕСТИТЬ ОстаткиСредств
	|ИЗ
	|	РегистрНакопления.ДоступныеСредства.ОстаткиИОбороты(
	|			&НачалоПериода,
	|			&КонецПериода,
	|			День,
	|			,
	|			Валюта = &Валюта
	|				ИЛИ &Валюта = ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка)) КАК ДоступныеСредстваОстаткиИОбороты
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Валюта
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КурсыВалют.Период КАК Период,
	|	ВЫБОР
	|		КОГДА ОстаткиСредств.Валюта ЕСТЬ NULL 
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ЕстьОстаток,
	|	КурсыВалют.Курс * КурсыВалют.Кратность КАК Курс,
	|	КурсыВалют.Валюта КАК Валюта,
	|	ЕСТЬNULL(ОстаткиСредств.СуммаВВалюте, 0) КАК СуммаВВалюте,
	|	ЕСТЬNULL(ОстаткиСредств.СуммаВВалюте * КурсыВалют.Курс * КурсыВалют.Кратность, 0) КАК Сумма,
	|	ОстаткиСредств.ЦветB КАК ЦветB,
	|	ОстаткиСредств.ЦветG КАК ЦветG,
	|	ОстаткиСредств.ЦветR КАК ЦветR
	|ИЗ
	|	РегистрСведений.КурсыВалют КАК КурсыВалют
	|		ЛЕВОЕ СОЕДИНЕНИЕ ОстаткиСредств КАК ОстаткиСредств
	|		ПО (ОстаткиСредств.Период = КурсыВалют.Период)
	|			И (ОстаткиСредств.Валюта = КурсыВалют.Валюта)
	|			И (ОстаткиСредств.Валюта <> &ВалютаРуб)
	|ГДЕ
	|	КурсыВалют.Период МЕЖДУ &НачалоПериода И &КонецПериода
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ОстаткиСредств.Период,
	|	ИСТИНА,
	|	1,
	|	ОстаткиСредств.Валюта,
	|	ОстаткиСредств.СуммаВВалюте,
	|	ОстаткиСредств.СуммаВВалюте,
	|	ОстаткиСредств.ЦветB,
	|	ОстаткиСредств.ЦветG,
	|	ОстаткиСредств.ЦветR
	|ИЗ
	|	ОстаткиСредств КАК ОстаткиСредств
	|ГДЕ
	|	ОстаткиСредств.Валюта = &ВалютаРуб
	|
	|УПОРЯДОЧИТЬ ПО
	|	Валюта,
	|	Период
	|ИТОГИ
	|	СУММА(СуммаВВалюте),
	|	СУММА(Сумма),
	|	МАКСИМУМ(ЦветB),
	|	МАКСИМУМ(ЦветG),
	|	МАКСИМУМ(ЦветR)
	|ПО
	|	Валюта";
	
	Возврат ТекстЗапроса;
	
КонецФункции


Функция ПолучитьОсновнуюВалюту() Экспорт
	
	Возврат Константы.ОсновнаяВалюта.Получить();
	
КонецФункции

Процедура УстановитьОсновнуюВалюту() Экспорт
	
	Константы.ОсновнаяВалюта.Установить();
	
КонецПроцедуры

