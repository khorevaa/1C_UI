﻿
&НаСервере
Процедура Команда1НаСервере()
	
	Об = ОбработкаОбъект();
	Об.Тест_ДашбордыСериализовать();
	
КонецПроцедуры

&НаКлиенте
Процедура Команда1(Команда)
	Команда1НаСервере();
КонецПроцедуры

Функция ОбработкаОбъект()
	
	
	Возврат РеквизитФормыВЗначение("Объект");
	
КонецФункции

