﻿#Область ПрограммныйИнтерфейс

Процедура Создать (Этот) Экспорт
	
	Этот.ТипДиаграммы = Неопределено;
	ЗадатьНачальныеНастройки(Этот);
	
КонецПроцедуры

Процедура СФормировать(Этот) Экспорт
	
	Для каждого Параметр Из Этот.Параметры Цикл
		
		Если Не ЗначениеЗаполнено(Параметр.Значение) Тогда
			КодОшибки = 1;
			Дашборды.СообщитьОбОшибке(КодОшибки);
		КонецЕсли;
		
	КонецЦикла;
	
	СформироватьВиджетКурсВалют(Этот);
	
КонецПроцедуры

Процедура РазместитьВИнтерфейсе(Форма, Этот) Экспорт
	
	ИменаСтолбцов = "ВиджетКурсаВалют%";
	ИменаРодителей = "ГруппаВиджетКурсовВалютЦБ";
	
	ДашбордыФормы.ЗаполнитьЭлементыФормыПоТаблице(Форма, Этот.Результат[Перечисления.ВалютныеОператоры.ЦБ], ИменаСтолбцов, ИменаРодителей);
	
	ИменаСтолбцов = "ВиджетКурсаВалютYahoo%";
	ИменаРодителей = "ГруппаВиджетКурсовВалютYahoo";
	
	ДашбордыФормы.ЗаполнитьЭлементыФормыПоТаблице(Форма, Этот.Результат[Перечисления.ВалютныеОператоры.Yahoo], ИменаСтолбцов, ИменаРодителей);
	
КонецПроцедуры

#КонецОбласти

Процедура СформироватьВиджетКурсВалют(Этот)
	
	ОсновнаяВалюта = ЗапросыВспомогательныеДанные.ПолучитьОсновнуюВалюту();
	ОсновнаяВалютаСимвол = ОсновнаяВалюта.Символ;
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Дата",Этот.Параметры.Дата);
	
	Сутки = 86400;
	
	ДеньДаты = ДеньНедели(Этот.Параметры.Дата);
	Если ДеньДаты = 7 Тогда
		ПредыдущийДень = Сутки * 2;
	ИначеЕсли ДеньДаты = 1 Тогда
		ПредыдущийДень = Сутки * 3; 
	Иначе
		ПредыдущийДень = Сутки; 
	КонецЕсли;
	
	Запрос.УстановитьПараметр("ПредыдущаяДата",НачалоДня(КонецДня(Этот.Параметры.Дата)-ПредыдущийДень));
	
	Запрос.УстановитьПараметр("ОснВалюта",ОсновнаяВалюта);
	
	Результат = Новый Соответствие;
	Для каждого Оператор Из Этот.ПриватныеСвойства.ВалютныеОператоры Цикл
		
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ПоследниеКурсыВалют.Дата,
		|	ПоследниеКурсыВалют.Курс,
		|	ПоследниеКурсыВалют.Символ,
		|	ПоследниеКурсыВалют.Наименование,
		|	ВЫБОР
		|		КОГДА КурсыВалют.Курс ЕСТЬ NULL 
		|			ТОГДА 0
		|		ИНАЧЕ ЕСТЬNULL(ПоследниеКурсыВалют.Курс, 0) - ЕСТЬNULL(КурсыВалют.Курс, 0)
		|	КОНЕЦ КАК РазницаВчерашнийКурс
		|ИЗ
		|	(ВЫБРАТЬ
		|		КурсыВалютСрезПоследних.Период КАК Дата,
		|		КурсыВалютСрезПоследних.Курс КАК Курс,
		|		КурсыВалютСрезПоследних.Валюта.Символ КАК Символ,
		|		КурсыВалютСрезПоследних.Валюта.Наименование КАК Наименование,
		|		КурсыВалютСрезПоследних.Валюта КАК Валюта
		|	ИЗ
		|		&ИмяРегистра КАК КурсыВалютСрезПоследних) КАК ПоследниеКурсыВалют
		|		ЛЕВОЕ СОЕДИНЕНИЕ &ИмяСоединяемогоРегистра КАК КурсыВалют
		|		ПО ПоследниеКурсыВалют.Валюта = КурсыВалют.Валюта
		|			И (КурсыВалют.Период = &ПредыдущаяДата)";
			
		Если Оператор = Перечисления.ВалютныеОператоры.ЦБ тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"&ИмяРегистра","РегистрСведений.КурсыВалют.СрезПоследних(&Дата, Валюта <> &ОснВалюта)");
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"&ИмяСоединяемогоРегистра","РегистрСведений.КурсыВалют");
		Иначе
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"&ИмяРегистра","РегистрСведений.КурсыВалютОператоров.СрезПоследних(&Дата, Валюта <> &ОснВалюта)");
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"&ИмяСоединяемогоРегистра","РегистрСведений.КурсыВалютОператоров");
		КонецЕсли;
		
		Запрос.Текст = ТекстЗапроса;
		Выборка = Запрос.Выполнить().Выбрать();
		
		РезультатТЗ = Новый ТаблицаЗначений;
		РезультатТЗ.Колонки.Добавить("Заголовок");
		
		Пока Выборка.Следующий() Цикл
			
			ДатаКурса = Новый ФорматированнаяСтрока("Курс на "+ Формат(Выборка.Дата, "ДФ=dd.MM") + Символы.ПС, ШрифтыСтиля.ОбычныйШрифтТекста);
			Символ = Новый ФорматированнаяСтрока(Выборка.Символ + " ", ШрифтыСтиля.ШрифтГигантский);
			Курс = Новый ФорматированнаяСтрока(ДашбордыФормы.ФорматДенежнойЕдиницы(Выборка.Курс, ОсновнаяВалютаСимвол, 2) + Символы.ПС, ШрифтыСтиля.ОченьКрупныйШрифтТекста);
			
			Если Выборка.РазницаВчерашнийКурс >= 0 Тогда
				Разница = Новый ФорматированнаяСтрока("     +"+ Формат(Выборка.РазницаВчерашнийКурс, "ЧДЦ=2") , ШрифтыСтиля.ОбычныйШрифтТекста, ЦветаСтиля.ЦветПоступление);
			ИначеЕсли Выборка.РазницаВчерашнийКурс < 0 Тогда
				Разница = Новый ФорматированнаяСтрока("     -"+ Формат(Выборка.РазницаВчерашнийКурс, "ЧДЦ=2") , ШрифтыСтиля.ОбычныйШрифтТекста, ЦветаСтиля.ЦветСписание);
			КонецЕсли;
			
			Массив = Новый Массив;
			Массив.Добавить(ДатаКурса);
			Массив.Добавить(Символ);
			Массив.Добавить(Курс);
			Массив.Добавить(Разница);
			
			СтрокаРезультата = РезультатТЗ.Добавить();
			СтрокаРезультата.Заголовок = Новый ФорматированнаяСтрока(Массив);
			
		КонецЦикла;
		
		РезультатМассив = ОбщегоНазначения.ТаблицаЗначенийВМассив(РезультатТЗ);
		Результат.Вставить(Оператор, РезультатМассив);
		
	КонецЦикла;
	
	Этот.Результат = Результат;
	
КонецПроцедуры

Процедура ЗадатьНачальныеНастройки(Этот)
	
	Этот.Параметры.Вставить("Дата");
	
	Операторы = Новый Массив;
	Операторы.Добавить(Перечисления.ВалютныеОператоры.ЦБ);
	Операторы.Добавить(Перечисления.ВалютныеОператоры.Yahoo);
	
	Этот.ПриватныеСвойства.Вставить("ВалютныеОператоры", Операторы);

КонецПроцедуры
