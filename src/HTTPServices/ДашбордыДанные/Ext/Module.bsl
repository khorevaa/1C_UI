﻿
Функция totalGain(Запрос)
	
	ВсегоЗаработано = Дашборды.Создать(Перечисления.ВидыДашбордов.ВсегоЗаработано);
	ВсегоЗаработано.Параметры.Дата = ТекущаяДата();
	Результат = Дашборды.Сериализовать(ВсегоЗаработано);
	
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.УстановитьТелоИзСтроки(Результат);
	Возврат Ответ;
	
КонецФункции

Функция wealthChanges(Запрос)
	
	ДинамикаКапита = Дашборды.Создать(Перечисления.ВидыДашбордов.ДинамикаКапитала);
	ДинамикаКапита.Параметры.Дата = ТекущаяДата();
	Результат = Дашборды.Сериализовать(ДинамикаКапита);
	
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.УстановитьТелоИзСтроки(Результат);
	Возврат Ответ;
	
КонецФункции
