﻿
Функция ОбновитьКурсыВалютИТоваров(Параметры, АдресРезультата) Экспорт
	
	ЗаданиеВыполнено = Ложь;
	
	Попытка
		РаботаСКурсамиВалют.ЗагрузитьАктуальныйКурс();
		РаботаСКурсамиАльтернативныйВызовСервера.ЗагрузитьКурсыВалютYahoo();
		РаботаСКурсамиАльтернативныйВызовСервера.ЗагрузитьКурсыТоварныхРынков();
		ЗаданиеВыполнено = Истина;
	Исключение
		Инфо = ИнформацияОбОшибке();
		ЗаписьЖурналаРегистрации(Нстр("ru = 'Обновление курсов валют'"),
			УровеньЖурналаРегистрации.Ошибка, 
			Метаданные.ОбщиеМодули.АктуализацияКурсовСервер,,
			Инфо.ИмяМодуля +". "+Инфо.НомерСтроки+". "+Инфо.Описание);
	КонецПопытки;
	
	ПоместитьВоВременноеХранилище(ЗаданиеВыполнено, АдресРезультата);
		
КонецФункции
