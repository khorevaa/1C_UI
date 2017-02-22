﻿#Область ПрограммныйИнтерфейс

Процедура Создать (Этот) Экспорт
	
	Этот.ТипДиаграммы = ТипДиаграммы.График;
	Этот.Результат = Новый Диаграмма;
	
	ЗадатьНачальныеНастройки(Этот);
	
КонецПроцедуры

Процедура СФормировать(Этот) Экспорт
	
	Для каждого Параметр Из Этот.Параметры Цикл
		
		//Если Не ЗначениеЗаполнено(Параметр.Значение) Тогда
		//	КодОшибки = 1;
		//	Дашборды.СообщитьОбОшибке(КодОшибки);
		//КонецЕсли;
		
	КонецЦикла;
	
	СформироватьКурсыВалют(Этот);
	
КонецПроцедуры

Процедура РазместитьВИнтерфейсе(Форма, Этот) Экспорт
	
	Этот.ПриватныеСвойства.ОбработчикЛегенды.ИмяСобытия = "Нажатие";
	Этот.ПриватныеСвойства.ОбработчикЛегенды.Действие = "ОткрытьОтчетКурсовВалют";
	Этот.ПриватныеСвойства.ГруппаЭлементаЛегенды = "ГруппаКурсыВалютЛегенда";
	
	ДашбордыФормы.ЗаполнитьЛегенду(Форма, Этот);
	
	Форма.ГрафикКурсовВалют = Этот.Результат;
	
КонецПроцедуры

#КонецОбласти

Процедура СформироватьКурсыВалют(Этот)
	
	Этот.Результат.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("НачалоПериода", Этот.Параметры.НачалоПериода);
	Запрос.УстановитьПараметр("ОкончаниеПериода", Этот.Параметры.ОкончаниеПериода);
	Запрос.УстановитьПараметр("Валюта", Этот.Параметры.Валюта);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	КурсыВалют.Период КАК Период,
	|	КурсыВалют.Валюта КАК Валюта,
	|	КурсыВалют.Курс КАК КурсМакс,
	|	КурсыВалют.Курс КАК КурсМин,
	|	Валюты.Наименование КАК ИмяВалюты,
	|	Валюты.ЦветR КАК ЦветR,
	|	Валюты.ЦветG КАК ЦветG,
	|	Валюты.ЦветB КАК ЦветB
	|ИЗ
	|	РегистрСведений.КурсыВалют КАК КурсыВалют
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Валюты КАК Валюты
	|		ПО КурсыВалют.Валюта = Валюты.Ссылка
	|ГДЕ
	|	КурсыВалют.Период МЕЖДУ &НачалоПериода И &ОкончаниеПериода
	|	И (Валюты.Ссылка = &Валюта
	|			ИЛИ &Валюта = ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка))
	|ИТОГИ
	|	МАКСИМУМ(КурсМакс),
	|	МИНИМУМ(КурсМин),
	|	МИНИМУМ(ИмяВалюты),
	|	МАКСИМУМ(ЦветR),
	|	МАКСИМУМ(ЦветG),
	|	МАКСИМУМ(ЦветB)
	|ПО
	|	ОБЩИЕ,
	|	Валюта";
	
	ВыборкаОбщая = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	Пока ВыборкаОбщая.Следующий() Цикл 
		
		// Нужно, чтобы сместить начало графика к ближним значениям
		Этот.Результат.МаксимальноеЗначение = ВыборкаОбщая.КурсМакс;
		Этот.Результат.МинимальноеЗначение = ВыборкаОбщая.КурсМин;
		Этот.Результат.БазовоеЗначение = ВыборкаОбщая.КурсМин - 1;
		
		ВыборкаВалют = ВыборкаОбщая.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		
		Пока ВыборкаВалют.Следующий() Цикл
			
			Серия = Этот.Результат.УстановитьСерию(ВыборкаВалют.Валюта);
			Серия.Маркер = ТипМаркераДиаграммы.Нет;
			Серия.Текст = ВыборкаВалют.ИмяВалюты;
			
			Серия.Цвет = ОбщегоНазначенияУИ.ЦветRGB(
				ВыборкаВалют.ЦветR, ВыборкаВалют.ЦветG, ВыборкаВалют.ЦветB);
				
			ВыборкаПериоды = ВыборкаВалют.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
			
			ПерваяТочкаИнтервала = 0;
			
			ТабРез = Новый ТаблицаЗначений;
			ТабРез.Колонки.Добавить("Дата");
			Для Счетчик = 0 По ВыборкаПериоды.Количество()-1 Цикл
				
				ВыборкаПериоды.Следующий();
				
				Если Счетчик = 0 Или Счетчик = ВыборкаПериоды.Количество() -1 Тогда
					// первую и последнюю дату включаем всегда
				ИначеЕсли Этот.Параметры.Интервал = Перечисления.ИнтервалПериода.Год Тогда
					// Берем с каждого месяца по одной дате, которая встретилась первой.
					НоваяТочкаИнтервала = Месяц(ВыборкаПериоды.Период);
					Если НоваяТочкаИнтервала = ПерваяТочкаИнтервала Тогда
						Продолжить;
					КонецЕсли;
					ПерваяТочкаИнтервала = НоваяТочкаИнтервала;
				ИначеЕсли Этот.Параметры.Интервал = Перечисления.ИнтервалПериода.Полугодие Тогда
					// Берем с каждой недели - понедельник.
					НоваяТочкаИнтервала = ДеньНедели(ВыборкаПериоды.Период);
					Если НоваяТочкаИнтервала <> 1 Тогда
						Продолжить;
					КонецЕсли;
				КонецЕсли;
				
				СтрокаТаб = ТабРез.Добавить();
				СтрокаТаб.Дата = ВыборкаПериоды.Период;
				
				Точка = Этот.Результат.УстановитьТочку(
					Формат(ВыборкаПериоды.Период, ДашбордыФормы.ФорматДаты(Этот.Параметры.Интервал)));
				Этот.Результат.УстановитьЗначение(Точка, Серия, ВыборкаПериоды.КурсМакс, ВыборкаПериоды.КурсМакс);
				
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗадатьНачальныеНастройки(Этот)
	
	Этот.Результат.ТипДиаграммы = ТипДиаграммы.График;
	
	Этот.Результат.ОтображатьЛегенду = Ложь;
	Этот.Результат.ОтображатьЗаголовок = Ложь;
	Этот.Результат.АвтомаксимальноеЗначение = Ложь;
	Этот.Результат.АвтоминимальноеЗначение = Ложь;
	
	Этот.Результат.ОбластьПостроения.ЦветШкалы = WebЦвета.СеребристоСерый;
	Этот.Результат.ОбластьПостроения.ОтображатьШкалу = Истина;
	Этот.Результат.ОбластьПостроения.ЛинииШкалы = Новый Линия(ТипЛинииДиаграммы.Сплошная);
	Этот.Результат.ОбластьПостроения.Лево = 0.01;
	Этот.Результат.ОбластьПостроения.ОтображатьЛинииЗначенийШкалы = Истина;
	Этот.Результат.ОбластьПостроения.ЛинииШкалы = Новый Линия(ТипЛинииДиаграммы.Пунктир);
	
	Этот.Результат.Рамка = Новый Рамка(ТипРамкиЭлементаУправления.БезРамки); 
	
	Этот.Параметры.Вставить("НачалоПериода");
	Этот.Параметры.Вставить("ОкончаниеПериода");
	Этот.Параметры.Вставить("Интервал");
	Этот.Параметры.Вставить("Валюта", Справочники.Валюты.ПустаяСсылка());
	
	ОбработчикЛегенды = Новый Структура("ИмяСобытия,Действие");
	Этот.ПриватныеСвойства.Вставить("ОбработчикЛегенды", ОбработчикЛегенды);
	
	Этот.ПриватныеСвойства.Вставить("ГруппаЭлементаЛегенды");
	
КонецПроцедуры
