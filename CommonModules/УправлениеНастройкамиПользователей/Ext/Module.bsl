﻿
Функция ПолучитьОсновнуюПлатежнуюСистему() Экспорт
	
	Возврат ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ПерсональныеНастройки", "ОсновнаяПлатежнаяСистема",, , ИмяПользователя());
	
КонецФункции

Функция ПолучитьОсновнуюВалюту() Экспорт
	
	Возврат ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ПерсональныеНастройки", "ОсновнаяВалюта",, , ИмяПользователя());
	
КонецФункции

Функция ПолучитьОсновнойИсточникСредств() Экспорт
	
	Возврат ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ПерсональныеНастройки", "ОсновнойИсточникСредств",, , ИмяПользователя());
	
КонецФункции

Функция ПолучитьАктивныеДашборды() Экспорт
	
	Возврат ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ПерсональныеНастройки", "АктивныеДашборды",, , ИмяПользователя());
	
КонецФункции

Функция ПолучитьПризнакОбновленияКурсов() Экспорт
	
	Возврат ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ПерсональныеНастройки", "ОбновлятьКурсыАвтоматически",, , ИмяПользователя());
	
КонецФункции

