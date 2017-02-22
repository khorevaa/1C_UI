﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	
	// регистр ДоступныеСредства
	Движения.ДоступныеСредства.Записывать = Истина;
	Движение = Движения.ДоступныеСредства.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
	Движение.Период = Дата;
	Движение.ПлатежнаяСистема = ПлатежнаяСистемаИсточник;
	Движение.Валюта = ВалютаИсточник;

	Если ВидПеревода = "Основная" Тогда
		Движение.СуммаВВалюте = СуммаИсточник;
	Иначе
		Движение.СуммаВВалюте = СуммаИсточник;
	КонецЕсли;
	
	Движение = Движения.ДоступныеСредства.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = Дата;
	Движение.ПлатежнаяСистема = ПлатежнаяСистемаПриемник;
	Движение.Валюта = ВалютаПриемник;
	
	Если ВидПеревода = "Основная" Тогда
		Движение.СуммаВВалюте = СуммаПриемник;
	Иначе
		Движение.СуммаВВалюте = СуммаПриемник;
	КонецЕсли;
	
	Движения.ДоступныеСредства.Записать();
	
	Если Не КонтрольОстатков.ОстаткиВалютыДостаточны(ПлатежнаяСистемаИсточник, ВалютаИсточник, Дата, "Объект.СуммаИсточник", СуммаИсточник) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
КонецПроцедуры
