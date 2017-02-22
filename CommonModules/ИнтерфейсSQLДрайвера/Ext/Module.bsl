﻿
#Область СтандартныйAPI

Функция НативноеПодключениеБД(Параметры) Экспорт
	
	РеляционнаяБаза = БазаSQL();
	
	Параметры.Вставить("ИмяБазы", ИмяБазыSQL());
	
	НастройкиСоединения = Новый ПараметрыСоединенияВнешнегоИсточникаДанных; 
	НастройкиСоединения.АутентификацияОС = Ложь;
	НастройкиСоединения.ИмяПользователя = Параметры.Логин;
	НастройкиСоединения.Пароль = Параметры.Пароль;
	НастройкиСоединения.СУБД = Параметры.ТипСУБД;
	
	ШаблонСоединения = "DRIVER={SQL Server};SERVER=%1;DATABASE=%2";
	
	НастройкиСоединения.СтрокаСоединения = СтрШаблон(ШаблонСоединения, Параметры.Сервер, Параметры.ИмяБазы);
	
	РеляционнаяБаза.УстановитьОбщиеПараметрыСоединения(НастройкиСоединения);
	
	Попытка
		РеляционнаяБаза.УстановитьСоединение();
	Исключение
		// Базы нет, создадим ее небезопасно через ком.
		// Можно создать через ком через кластер, но конфигурация ориентирована на файловый режим работы.
		 КомСоединение = КомПодключениеБД(Параметры);
		 ТекстСозданиеБазы = ЗапросСозданиеБазы(Параметры.ИмяБазы);
		 ВыполнитьКоманду(КомСоединение, ТекстСозданиеБазы);
	КонецПопытки;
	
	СохранитьСоединениеСБД(РеляционнаяБаза);
	
	Возврат РеляционнаяБаза;
	
КонецФункции

#КонецОбласти

#Область COM_ADO

Функция КОМПодключениеБД(Параметры) Экспорт

	СоединениеSQL = Новый ComObject("ADODB.Connection");
	
	ШаблонСоединения = "Provider=SQLOLEDB.1; Server=%1;, Database=%2; Uid=%3; Pwd=%4;";
	
	СтрокаСоединения = СтрШаблон(ШаблонСоединения, Параметры.Сервер, Параметры.ИмяБазы, Параметры.Логин, Параметры.Пароль);
	
	Попытка
		СоединениеSQL.Open(СтрокаСоединения);
	Исключение
		ВызватьИсключение "Не удалось подключиться к базе SQL";
	КонецПопытки;
	
	Возврат СоединениеSQL;
	
КонецФункции

Функция ВыполнитьКоманду(Соединение, ТекстКоманды) Экспорт
	
	Команда = Новый ComObject("ADODB.Command");
	Команда.ActiveConnection = Соединение;
	Команда.CommandText = ТекстКоманды;
	Команда.CommandTimeout = 10000;
	
	Попытка
		Команда.Execute();
	Исключение
		ВызватьИсключение "Не удалось выполнить команду SQL";
	КонецПопытки;
	
КонецФункции

#КонецОбласти

#Область StandartSQL_Запросы

Функция ЗапросСозданиеБазы(ИмяБазы)
	
	ТекстЗапроса = "
	|DECLARE @NameBase NVARCHAR(1) = '%1';
	|
	|IF Object_ID (@NameBase) <> NULL
	|	Return
	| 
	|CREATE DATABASE %1";
	
	ТекстЗапроса = СтрШаблон(ТекстЗапроса, ИмяБазы); 
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

Функция БазаSQL()
	
	Возврат ВнешниеИсточникиДанных.ReportStorage;
	
КонецФункции

Функция ИмяБазыSQL()
	
	Возврат Метаданные.ВнешниеИсточникиДанных.ReportStorage.Имя;
	
КонецФункции

Функция СохранитьСоединениеСБД(РеляционнаяБаза)
	
	ПараметрыСеанса.СоединениеБД = Новый ХранилищеЗначения(РеляционнаяБаза);
	
КонецФункции
