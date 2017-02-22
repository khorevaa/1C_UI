﻿
#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИспользоватьДополнительныеРеквизитыИСведения = Константы.ИспользоватьДополнительныеРеквизитыИСведения.Получить();
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытиЭлементовФормы

&НаКлиенте
Процедура НастройкиВалют(Команда)
	
	ОткрытьФорму("ОбщаяФорма.НастройкиВалют");
	
КонецПроцедуры

&НаКлиенте
Процедура ПерсональныеНастройки(Команда)
	ОткрытьФорму("ОбщаяФорма.ПерсональныеНастройки");
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьДополнительныеРеквизитыИСведенияПриИзменении(Элемент)
	
	ИзменитьНастройкуДопРеквизитов(ИспользоватьДополнительныеРеквизитыИСведения);
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Процедура ИзменитьНастройкуДопРеквизитов(Использовать)
	
	ЗначениеКонстанты = Константы.ИспользоватьДополнительныеРеквизитыИСведения.СоздатьМенеджерЗначения();
	ЗначениеКонстанты.Прочитать();
	ЗначениеКонстанты.Значение = Использовать;
	ЗначениеКонстанты.Записать();
	
	ЗначениеКонстанты = Константы.ИспользоватьОбщиеДополнительныеРеквизитыИСведения.СоздатьМенеджерЗначения();
	ЗначениеКонстанты.Прочитать();
	ЗначениеКонстанты.Значение = Использовать;
	ЗначениеКонстанты.Записать();
	
	ЗначениеКонстанты = Константы.ИспользоватьОбщиеДополнительныеЗначения.СоздатьМенеджерЗначения();
	ЗначениеКонстанты.Прочитать();
	ЗначениеКонстанты.Значение = Использовать;
	ЗначениеКонстанты.Записать();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы = Форма.Элементы;
	Объект = Форма.Объект;
	
	Элементы.НаборыДополнительныхРеквизитовИСведений.Доступность = Форма.ИспользоватьДополнительныеРеквизитыИСведения;
	
КонецПРоцедуры

&НаКлиенте
Процедура НаборыДополнительныхРеквизитовИСведений(Команда)
	
	ОткрытьФорму("Справочник.НаборыДополнительныхРеквизитовИСведений.ФормаСписка");
	
КонецПроцедуры

#КонецОбласти


