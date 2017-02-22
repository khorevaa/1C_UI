﻿
////////////////////////////////////////////////////////////////////////////////
// Обработка валют и их курсов
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

Процедура ЗагрузитьАктуальныйКурс() Экспорт
	
	РаботаСКурсамиВалют.ЗагрузитьАктуальныйКурс();
	
КонецПроцедуры

#Область УстаревшиеПроцедурыИФункции

Функция СуммаВОсновнойВалюте(Дата, Валюта, Сумма) Экспорт
	
	Курс = РегистрыСведений.КурсыВалют.ПолучитьПоследнее(Дата, Новый Структура("Валюта",Валюта)).Курс;
	Возврат Сумма*Курс;
	
КонецФункции

Функция СуммаВоВторойВалюте(Дата, Валюта, Сумма) Экспорт
	
	ВтораяВалюта = ПараметрыСеанса.ДополнительнаяВалюта;
	
	Если Валюта<>ВтораяВалюта Тогда
		
		КроссСумма = СуммаВОсновнойВалюте(Дата,Валюта,Сумма);
		Курс = РегистрыСведений.КурсыВалют.ПолучитьПоследнее(Дата, Новый Структура("Валюта",ВтораяВалюта)).Курс;
		Возврат КроссСумма/Курс;
		
	Иначе
		Возврат Сумма;
	КонецЕсли;
	
КонецФункции

Процедура ЗагрузитьКурсыВалют() Экспорт
	
	//ДатаНачалаЗагрузкиКурсов = Константы.ДатаНачалаЗагрузкиКурсов.Получить();
	//
	//Если НЕ ЗначениеЗаполнено(ДатаНачалаЗагрузкиКурсов) Тогда
	//	Возврат;
	//КонецЕсли; 
	//
	//Запрос = Новый Запрос;
	//Запрос.Текст = 
	//	"ВЫБРАТЬ
	//	|	Валюты.Ссылка,
	//	|	Валюты.КодВалюты,
	//	|	ЕСТЬNULL(КурсыВалютСрезПоследних.Период, ДАТАВРЕМЯ(1, 1, 1)) КАК ДатаПоследнегоКурса
	//	|ИЗ
	//	|	Справочник.Валюты КАК Валюты
	//	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних КАК КурсыВалютСрезПоследних
	//	|		ПО (КурсыВалютСрезПоследних.Валюта = Валюты.Ссылка)
	//	|ГДЕ
	//	|	Валюты.Ссылка <> &Ссылка
	//	|	И Валюты.ОбновлятьКурс
	//	|	И Валюты.ПометкаУдаления = ЛОЖЬ
	//	|
	//	|УПОРЯДОЧИТЬ ПО
	//	|	ДатаПоследнегоКурса";
	//
	//Запрос.УстановитьПараметр("Ссылка", ПараметрыСеанса.ОсновнаяВалюта);
	//
	//ОбновляемыеВалюты = Запрос.Выполнить().Выгрузить();
	//
	//Если НЕ ОбновляемыеВалюты.Количество() Тогда
	//	Возврат;
	//КонецЕсли;
	//
	//ДатаНачалаЗагрузкиКурсов = Макс(ДатаНачалаЗагрузкиКурсов,ОбновляемыеВалюты[0].ДатаПоследнегоКурса);
	//
	//ТекущийДень = НачалоДня(ТекущаяДата());
	//Если ДатаНачалаЗагрузкиКурсов = ТекущийДень Тогда
	//	Возврат;
	//КонецЕсли; 
	//
	//Прокси = WSСсылки.CBR_DailyInfoWebServ.СоздатьWSПрокси("http://web.cbr.ru/", "DailyInfo", "DailyInfoSoap");
	//ТипWSПараметра = Прокси.ФабрикаXDTO.Пакеты.Получить("http://web.cbr.ru/").Получить("GetCursOnDate");
	//WSПараметр	   = Прокси.ФабрикаXDTO.Создать(ТипWSПараметра);
	//
	//ОдинДень = 60*60*24;
	//
	//
	//Пока ДатаНачалаЗагрузкиКурсов<>ТекущийДень Цикл
	//	
	//	ДатаНачалаЗагрузкиКурсов = ДатаНачалаЗагрузкиКурсов+ОдинДень;
	//	
	//	WSПараметр.On_Date	= ДатаНачалаЗагрузкиКурсов;
	//	
	//	Попытка
	//		//Вызываем метод веб-сервиса, записываем результат в переменную КурсыВалют.
	//		КурсыВалют = Прокси.GetCursOnDate(WSПараметр);
	//	Исключение
	//		ЗаписьЖурналаРегистрации(
	//			Нстр("ru = 'Получение курсов валют'"),
	//			УровеньЖурналаРегистрации.Информация
	//			,
	//			,
	//			,
	//			Нстр("ru = 'не удалось получить курсы валют через веб-сервис'"));
	//		Возврат;
	//	КонецПопытки;
	//	
	//	ОсталосьОбновитьВалют = ОбновляемыеВалюты.Количество();
	//	
	//	Для Каждого Элемент Из КурсыВалют.GetCursOnDateResult.diffgram.ValuteData.ValuteCursOnDate Цикл 
	//		
	//		//НазваниеВалюты      = Элемент.Vname;
	//		//Номинал             = Элемент.Vnom;
	//		//ЦифровойКодВалюты   = Элемент.Vcode;
	//		//СимвольныйКодВалюты = Элемент.VChCode;
	//		//КурсВалюты          = Элемент.Vcurs;
	//		
	//		Валюта = ОбновляемыеВалюты.Найти(Элемент.Vcode,"КодВалюты");
	//		Если Валюта = Неопределено Тогда
	//			Продолжить;
	//		КонецЕсли;
	//		
	//		РС = РегистрыСведений.КурсыВалют.СоздатьМенеджерЗаписи();
	//		РС.Период = ДатаНачалаЗагрузкиКурсов;
	//		РС.Курс = Элемент.Vcurs;
	//		РС.Валюта = Валюта.Ссылка;
	//		РС.Записать();
	//		
	//		ОсталосьОбновитьВалют = ОсталосьОбновитьВалют - 1;
	//		
	//		Если НЕ ОсталосьОбновитьВалют Тогда
	//			Прервать;
	//		КонецЕсли;
	//                			
	//	КонецЦикла;		
	//         		
	//КонецЦикла;
	//              	
КонецПроцедуры

Функция ОсновнаяВалюта() Экспорт
	Возврат ПараметрыСеанса.ОсновнаяВалюта;
КонецФункции

Функция ДополнительнаяВалюта() Экспорт
	Возврат ПараметрыСеанса.ДополнительнаяВалюта;
КонецФункции

#КонецОбласти

#КонецОбласти