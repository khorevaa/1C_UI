﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Окна = ПолучитьОкна();
	
	Для каждого Окно ИЗ Окна Цикл
		
		Если Окно.НачальнаяСтраница Тогда
			Окно.Активизировать();
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры
